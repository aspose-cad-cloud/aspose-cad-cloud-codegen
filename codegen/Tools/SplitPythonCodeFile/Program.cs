using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Text.RegularExpressions;

namespace SplitPythonCodeFile
{
    internal class Program
    {
        private static void Main(string[] args)
        {
            //args = new[]
            //{
            //    @"C:\tmp\python\asposecadcloud\api\cad_api.py",
            //    @"C:\tmp\python\asposecadcloud\models\requests\"
            //};
            string apiFilePath = args[0];
            string requestsDir = args[1];

            if (!Directory.Exists(requestsDir))
            {
                Directory.CreateDirectory(requestsDir);
            }

            string text2 = File.ReadAllText(apiFilePath);

            var pattern = @"#  coding: utf-8[\s\S]*?<copyright company=""Aspose"" file=""(.*?).py""";
            MatchCollection matchCollection = Regex.Matches(text2, pattern);
            string text3 = string.Empty;
            Dictionary<string, string> dictionary = new Dictionary<string, string>();
            for (int i = matchCollection.Count - 1; i > 0; i--) // skip CadApi by checking for strong "greater than"
            {
                string str = matchCollection[i].Groups[0].ToString();
                string text4 = matchCollection[i].Groups[1].ToString();
                IEnumerable<string> arg_B5_0 = text4.Split(new string[]
                    {
                        "_"
                    },
                    StringSplitOptions.RemoveEmptyEntries);

                Func<string, string> upperCaser = (s) => s.ToUpper()[0] + s.Substring(1);

                IEnumerable<string> values = arg_B5_0.Select(upperCaser);
                string text5 = string.Join(string.Empty, values);
                dictionary.Add(text4, text5);
                int startIndex = text2.IndexOf(str!, StringComparison.Ordinal);
                text3 = text2.Substring(startIndex);
                text2 = text2.Substring(0, text2.Length - text3.Length);
                text3 = text3.Replace(text4, text5);
                File.WriteAllText(requestsDir + text4 + ".py", text3);
            }

            StringBuilder stringBuilder = new StringBuilder();
            IEnumerable<KeyValuePair<string, string>> arg_169_0 = dictionary;
            string arg_169_1 = text2;

            Func<string, KeyValuePair<string, string>, string> replacer = (s, pair) =>
            {
                return s.Replace(pair.Key, pair.Value);
            };

            text2 = arg_169_0.Aggregate(arg_169_1, replacer);
            foreach (KeyValuePair<string, string> current in dictionary)
            {
                stringBuilder.AppendFormat("from asposecadcloud.models.requests.{0} import {1}\n", current.Key, current.Value);
            }

            File.WriteAllText(requestsDir + "__init__.py", stringBuilder.ToString());
            File.WriteAllText(apiFilePath, text2);
        }
    }
}