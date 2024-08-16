// SplitCSharpCodeFile.Program
using System;
using System.IO;
using System.Text.RegularExpressions;

namespace SplitCSharpCodeFile
{
    public class Program
    {
        private static void Main(string[] args)
        {
//#if DEBUG
//            args = new [] { 
//                @"C:\tmp\csharp\src\Aspose.CAD.Cloud.Sdk\Api\CadApi.cs",
//                @"C:\tmp\csharp\src\Aspose.CAD.Cloud.Sdk\Model\Requests\" };
//#endif
            
            string path = args[0];
            string text = args[1];
            if (!Directory.Exists(text))
            {
                Directory.CreateDirectory(text);
            }
            
            string text2 = File.ReadAllText(path);
            //var pattern = @"// <copyright company=""Aspose"" file=""(.*?).cs"">";
            //string text3 = string.Empty;
            
            //string text2 = File.ReadAllText(path);
            MatchCollection matchCollection = Regex.Matches(text2, "// <copyright company=\"Aspose\" file=\"(.*?).cs\">");
            for (int num = matchCollection.Count - 1; num > 0; num--)
            {
                //string str = matchCollection[num].Groups[0].ToString();
                //string text4 = matchCollection[num].Groups[4].ToString();
                //string text5 = char.ToUpper(text4[0]).ToString() + text4.Substring(1);
                //int startIndex = text2.IndexOf(str!, StringComparison.Ordinal);
                //text3 = text2.Substring(startIndex);
                //text2 = text2.Substring(0, text2.Length - text3.Length);
                //text3 = text3.Replace(text4, text5);
                //File.WriteAllText(text + text5 + ".cs", string.Format("{0}", text3));
                
                
                string text3 = string.Concat(matchCollection[num].Groups[1], ".cs");
                int startIndex = text2.IndexOf("file=\"" + text3 + "\"", StringComparison.Ordinal) - 152;
                string text4 = text2.Substring(startIndex);
                text2 = text2.Substring(0, text2.Length - text4.Length);
                File.WriteAllText(text + text3, text4.TrimStart(Environment.NewLine.ToCharArray()));
            }
            File.WriteAllText(path, text2.TrimStart(Environment.NewLine.ToCharArray()));
        }
    }    
}