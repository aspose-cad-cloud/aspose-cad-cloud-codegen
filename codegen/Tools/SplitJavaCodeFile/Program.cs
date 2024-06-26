using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Text.RegularExpressions;

namespace SplitJavaCodeFile
{
    public class Program
    {
        public static void Main(string[] args)
        {
            //args = new[]
            //{
            //    @"C:\tmp\java\src\main\java\com\aspose\cad\cloud\api\cadApi.java",
            //    @"C:\tmp\java\src\main\java\com\aspose\cad\cloud\model\requests\"
            //};

            string path = args[0];
            string text = args[1];
            if (!Directory.Exists(text))
            {
                Directory.CreateDirectory(text);
            }

            var pattern = @"\/[\s\*]\r?\n\* (-*-)\r?\n\* <copyright company=""Aspose"" file=""(.*?).java"">";
            string text2 = File.ReadAllText(path);
            MatchCollection matchCollection = Regex.Matches(text2, pattern);
            string text3 = string.Empty;
            for (int i = matchCollection.Count - 1; i > 0; i--)
            {
                string str = matchCollection[i].Groups[0].ToString();
                string str2 = matchCollection[i].Groups[2].ToString();
                
                int startIndex = text2.IndexOf(str!, StringComparison.Ordinal);
                text3 = text2.Substring(startIndex);
                text2 = text2.Substring(0, text2.Length - text3.Length);
                File.WriteAllText(text + str2 + ".java", text3);
            }

            File.WriteAllText(path, text2);
        }
    }
}
