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
            string path = args[0];
            string text = args[1];
            if (!Directory.Exists(text))
            {
                Directory.CreateDirectory(text);
            }
            string text2 = File.ReadAllText(path);
            MatchCollection matchCollection = Regex.Matches(text2, " \\* <copyright company=\"Aspose\" file=\"(.*?).php\">");
            string text3 = string.Empty;
            for (int i = matchCollection.Count - 1; i > 0; i--)
            {
                string str = matchCollection[i].Groups[1] + ".php";
                string text4 = matchCollection[i].Groups[1].ToString();
                string text5 = char.ToUpper(text4[0]).ToString() + text4.Substring(1);
                int startIndex = text2.IndexOf("file=\"" + str + "\"") - 158;
                text3 = text2.Substring(startIndex);
                text2 = text2.Substring(0, text2.Length - text3.Length);
                text3 = text3.Replace(text4, text5);
                File.WriteAllText(text + text5 + ".php", string.Format("<?php\n{0}", text3));
            }
            File.WriteAllText(path, text2);
        }
    }
}
