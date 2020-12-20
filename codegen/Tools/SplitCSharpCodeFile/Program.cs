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
            string path = args[0];
            string text = args[1];
            if (!Directory.Exists(text))
            {
                Directory.CreateDirectory(text);
            }
            string text2 = File.ReadAllText(path);
            MatchCollection matchCollection = Regex.Matches(text2, "// <copyright company=\"Aspose\" file=\"(.*?).cs\">");
            for (int num = matchCollection.Count - 1; num > 0; num--)
            {
                string text3 = string.Concat(matchCollection[num].Groups[1], ".cs");
                int startIndex = text2.IndexOf("file=\"" + text3 + "\"") - 152;
                string text4 = text2.Substring(startIndex);
                text2 = text2.Substring(0, text2.Length - text4.Length);
                File.WriteAllText(text + text3, text4.TrimStart(Environment.NewLine.ToCharArray()));
            }
            File.WriteAllText(path, text2.TrimStart(Environment.NewLine.ToCharArray()));
        }
    }    
}