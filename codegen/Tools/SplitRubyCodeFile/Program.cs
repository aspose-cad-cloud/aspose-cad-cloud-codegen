using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Text.RegularExpressions;

namespace SplitRubyCodeFile
{
    internal class Program
    {
        internal static string UpperCaser(string p)
        {
            return char.ToUpper(p[0]).ToString() + p.Substring(1);
        }

        internal static string Replacer(string current, KeyValuePair<string, string> kv)
        {
            return current.Replace(kv.Key, kv.Value);
        }

        private static void Main(string[] args)
        {
            string path = args[0];
            string text = args[1];
            if (!Directory.Exists(text))
            {
                Directory.CreateDirectory(text);
            }

            string text2 = File.ReadAllText(path);
            MatchCollection matchCollection =
                Regex.Matches(text2, "# <copyright company=\"Aspose\" file=\"(.*?).rb\">");
            string text3 = string.Empty;
            Dictionary<string, string> dictionary = new Dictionary<string, string>();
            for (int i = matchCollection.Count - 1; i > 0; i--)
            {
                string str = matchCollection[i].Groups[1] + ".rb";
                string text4 = matchCollection[i].Groups[1].ToString();
                IEnumerable<string> arg_B5_0 = text4.Split(new string[]
                {
                    "_"
                }, StringSplitOptions.RemoveEmptyEntries);
                
                IEnumerable<string> values = arg_B5_0.Select(UpperCaser);
                string text5 = string.Join(string.Empty, values);
                dictionary.Add(text4, text5);
                int startIndex = text2.IndexOf("file=\"" + str + "\"") - 156;
                text3 = text2.Substring(startIndex);
                text2 = text2.Substring(0, text2.Length - text3.Length);
                text3 = text3.Replace(text4, text5);
                File.WriteAllText(text + text5 + ".rb", text3);
            }

            IEnumerable<KeyValuePair<string, string>> arg_165_0 = dictionary;
            string arg_165_1 = text2;
            
            text2 = arg_165_0.Aggregate(arg_165_1, Replacer);
            File.WriteAllText(path, text2);
        }
    }
}
