using CitizenFX.Core;
using CitizenFX.Core.Native;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace vorpstables_cl
{
    class GetConfig : BaseScript
    {
        public static JObject Config = new JObject();
        public static Dictionary<string, string> Langs = new Dictionary<string, string>();
        public static Dictionary<string, Dictionary<string, double>> HorseLists = new Dictionary<string, Dictionary<string, double>>();
        public static Dictionary<string, double> CartLists = new Dictionary<string, double>();
        public static Dictionary<string, Dictionary<string, List<uint>>> CompsLists = new Dictionary<string, Dictionary<string, List<uint>>>();
        public static Dictionary<string, Dictionary<string, double>> CompsPrices = new Dictionary<string, Dictionary<string, double>>();

        public GetConfig()
        {
            EventHandlers[$"{API.GetCurrentResourceName()}:SendConfig"] += new Action<string, ExpandoObject>(LoadDefaultConfig);
            TriggerServerEvent($"{API.GetCurrentResourceName()}:getConfig");
        }

        private void LoadDefaultConfig(string dc, ExpandoObject dl)
        {

            Config = JObject.Parse(dc);

            foreach (var l in dl)
            {
                Langs[l.Key] = l.Value.ToString();
            }

            foreach (JObject categories in GetConfig.Config["Horses"].Children<JObject>())
            {
                foreach (JProperty cat in categories.Properties())
                {

                    Dictionary<string, double> hlist = new Dictionary<string, double>();

                    foreach (JObject horse in cat.Value.Children<JObject>())
                    {

                        foreach (JProperty h in horse.Properties())
                        {
                            hlist.Add(h.Name, double.Parse(h.Value.ToString()));
                        }

                    }

                    HorseLists.Add(cat.Name, hlist);
                }
            }

            foreach (JObject carts in GetConfig.Config["Carts"].Children<JObject>())
            {
               
                foreach (JProperty cart in carts.Properties())
                {
                    CartLists.Add(cart.Name, cart.Value.ToObject<double>());
                }
            }

            foreach (JObject catComponents in GetConfig.Config["Complements"].Children<JObject>())
            {
                foreach (JProperty cat in catComponents.Properties())
                {

                    Dictionary<string, List<uint>> hlist = new Dictionary<string, List<uint>>();
                    Dictionary<string, double> clist = new Dictionary<string, double>();

                    foreach (JObject comps in cat.Value.Children<JObject>())
                    {

                        foreach (JProperty c in comps.Properties())
                        {
                            List<uint> hashes = new List<uint>();
                            for(int i = 0; i < c.Value.Count() -1; i++)
                            {
                                hashes.Add(FromHex(c.Value[i].ToString()));
                            }

                            hlist.Add(c.Name, hashes);
                            clist.Add(c.Name, double.Parse(c.Value[c.Value.Count() -1].ToString()));
                        }

                    }

                    CompsLists.Add(cat.Name, hlist);
                    CompsPrices.Add(cat.Name, clist);
                }
            }

            //Start When finish Loading
            InitStables.StartInit();
        }

        public static uint FromHex(string value)
        {   
            if ( value.StartsWith("0x", StringComparison.OrdinalIgnoreCase)) 
            {     
                value = value.Substring(2);   
            }  
            return (uint)Int32.Parse(value, NumberStyles.HexNumber); }
        }
}
