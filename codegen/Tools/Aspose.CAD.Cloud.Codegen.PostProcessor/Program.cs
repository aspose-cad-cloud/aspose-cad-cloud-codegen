using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace Aspose.CAD.Cloud.Codegen.PostProcessor
{
    class Program
    {
        static void Main(string[] args)
        {
#if DEBUG
            args = new [] { @"C:\Work\ASP\!Cloud\Aspose.CAD.Cloud.Codegen\spec\asposeforcloud_cad.json", @"c:\tmp\csharp\" };
#endif

            if (args.Length < 2)
            {
                Console.WriteLine("Usage: PostProcessor.exe <swagger JSON spec path> <swagger-codegen generated files folder>");
                return;
            }

            AddDefinitionMissingDescriptions(args[0], args[1]);
            ResolveStronglyTypedDtoOptions(args[0], args[1]);
            CapitalizePublicPropertyNames(args[0], args[1]);
        }

        private static void AddDefinitionMissingDescriptions(string swaggerSpecFile, string generatedFilesDir)
        {
            var json = (JObject)JsonConvert.DeserializeObject(File.ReadAllText(swaggerSpecFile));

            var definitions = json["definitions"] as JObject;
            foreach (JProperty definition in definitions.Properties())
            {
                if (!(((JObject)definition.Value).Properties()).Any(x => x.Name == "description"))
                {
                    ((JContainer)definition.Value).Add(new JProperty("description", Regex.Replace(definition.Name, "[A-Z]", match => " " + match.Value).Trim()));
                }
            }

            File.WriteAllText(swaggerSpecFile, json.ToString());
        }

        private static void ResolveStronglyTypedDtoOptions(string swaggerSpecFile, string generatedFilesDir)
        {
            var json = (JObject) JsonConvert.DeserializeObject(File.ReadAllText(swaggerSpecFile));

            var toProcess = new Dictionary<string, string>();

            var paths = json["paths"] as JObject;
            foreach (JProperty path in paths.Properties())
            {
                foreach (JProperty methodProperty in ((JObject) path.Value).Properties())
                {
                    JObject method = methodProperty.Value as JObject;
                    var operationId = method["operationId"].Value<string>();
                    foreach (JObject param in (JArray) method["parameters"])
                    {
                        //{
                        //    "type": "object",
                        //    "name": "options",
                        //    "in": "formData",
                        //    "description": "JSON-serialized export options passed as zero-indexed multipart/form-data. Follow #/definitions/BmpOptionsDTO model definition."
                        //}
                        try
                        {
                            if (param["type"].Value<string>() == "object"
                                && param["name"].Value<string>() == "options"
                                && param["in"].Value<string>() == "formData")
                            {
                                toProcess.Add(operationId + "Request.cs",
                                    FirstCharToUpper(path.Path.Substring(path.Path.LastIndexOf("/") + 1)) + "OptionsDTO");
                            }
                        }
                        catch
                        {
                        }
                    }
                }
            }

            foreach (var file in new DirectoryInfo(generatedFilesDir).EnumerateFiles("*.cs", SearchOption.AllDirectories))
            {
                if (toProcess.ContainsKey(file.Name))
                {
                    // public PutDrawingBmpRequest(System.IO.Stream drawingData, xxx options = null, string outPath = null, string storage = null)
                    var code = Regex.Replace(File.ReadAllText(file.FullName),
                        $"public {Path.GetFileNameWithoutExtension(file.Name)}\\(.*?\\, (.*) options", match =>
                        {
                            return match.Value
                                .Remove(match.Groups[1].Index - match.Index, match.Groups[1].Length)
                                .Insert(match.Groups[1].Index - match.Index, toProcess[file.Name]);
                        });

                    // public xxx options { get; set; }
                    code = Regex.Replace(code, "public (.*?) options { get; set; }", match =>
                    {
                        return match.Value
                            .Remove(match.Groups[1].Index - match.Index, match.Groups[1].Length)
                            .Insert(match.Groups[1].Index - match.Index, toProcess[file.Name]);
                    });

                    File.WriteAllText(file.FullName, code);
                }
            }
        }

        private static void CapitalizePublicPropertyNames(string swaggerSpecFile, string generatedFilesDir)
        {
            var propertyUsages = new List<string>();
            foreach (var file in new DirectoryInfo(generatedFilesDir)
                                        .EnumerateFiles("*.cs", SearchOption.AllDirectories)
                                        .OrderBy(x => x.Name == "CadApi.cs"))
            {
                // public xxx options { get; set; }
                var code = Regex.Replace(File.ReadAllText(file.FullName), "^\\s*public (.*) (.*?) { get;.*$", match =>
                {
                    propertyUsages.Add(match.Groups[2].Value);

                    return match.Value
                        .Remove(match.Groups[2].Index - match.Index, match.Groups[2].Length)
                        .Insert(match.Groups[2].Index - match.Index, FirstCharToUpper(match.Groups[2].Value));
                }, 
                RegexOptions.Multiline);

                foreach (var propertyUsage in propertyUsages)
                {
                    code = code.Replace("this." + propertyUsage, "this." + FirstCharToUpper(propertyUsage));
                    code = code.Replace("request." + propertyUsage, "request." + FirstCharToUpper(propertyUsage));
                }

                File.WriteAllText(file.FullName, code);
            }
        }

        private static string FirstCharToUpper(string input)
        {
            switch (input)
            {
                case null: throw new ArgumentNullException(nameof(input));
                case "": throw new ArgumentException($"{nameof(input)} cannot be empty", nameof(input));
                default: return input.First().ToString().ToUpper() + input.Substring(1);
            }
        }
    }
}
