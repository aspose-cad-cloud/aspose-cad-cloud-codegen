using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Text.RegularExpressions;

namespace SplitPhpCodeFile
{
    internal class Program
    {
        private static void Main(string[] args)
        {
            // };
            //args = new[]
            //{
            //    @"C:\Users\ArtemM\Desktop\cloud\aspose-cad-cloud-codegen\SDKS\PHP\src\Aspose\CAD\CadApi.php",
            //    @"C:\Users\ArtemM\Desktop\cloud\aspose-cad-cloud-codegen\SDKS\PHP\src\Aspose\CAD\Model\Requests\"
            //};
            
            string path = args[0];
            string text = args[1];
            if (!Directory.Exists(text))
            {
                Directory.CreateDirectory(text);
            }
            string text2 = File.ReadAllText(path);
            var pattern = @"[\s\<][\s\?]php\r?\n(.*?)[\s\*]+(-*-)\r?\n (.*?) <copyright company=""Aspose"" file=""(.*?).php"">";
            
            MatchCollection matchCollection = Regex.Matches(text2, pattern);
            string text3 = string.Empty;
            for (int i = matchCollection.Count - 1; i > 0; i--)
            {
                string str = matchCollection[i].Groups[0].ToString();
                string text4 = matchCollection[i].Groups[4].ToString();
                string text5 = char.ToUpper(text4[0]).ToString() + text4.Substring(1);
                int startIndex = text2.IndexOf(str!, StringComparison.Ordinal);
                text3 = text2.Substring(startIndex);
                text2 = text2.Substring(0, text2.Length - text3.Length);
                text3 = text3.Replace(text4, text5);
                File.WriteAllText(text + text5 + ".php", string.Format("{0}", text3));
            }
            File.WriteAllText(path, text2);
        }
    }
}
