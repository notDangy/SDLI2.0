using CitizenFX.Core;
using CitizenFX.Core.Native;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace vorpstables_sv
{
    public class StableDataManagment : BaseScript
    {
        public static dynamic VORPCORE;

        public StableDataManagment()
        {
            EventHandlers["vorpstables:BuyNewHorse"] += new Action<Player, string, string, string, double>(BuyNewHorse);
            EventHandlers["vorpstables:BuyNewCart"] += new Action<Player, string, string, double>(BuyNewCart);
            EventHandlers["vorpstables:BuyNewComp"] += new Action<Player, string, double, string, int>(BuyNewComp);
            EventHandlers["vorpstables:UpdateComp"] += new Action<Player, string, int>(UpdateComp);
            EventHandlers["vorpstables:SetDefaultHorse"] += new Action<Player, int>(SetDefaultHorse);
            EventHandlers["vorpstables:RemoveHorse"] += new Action<Player, int>(RemoveHorse);
            EventHandlers["vorpstables:TransferHorse"] += new Action<Player, int, int>(TransferHorse);
            EventHandlers["vorpstables:SetDefaultCart"] += new Action<Player, int>(SetDefaultCart);

            //Inventory
            EventHandlers["vorp_stables:TakeFromHorse"] += new Action<Player, string>(TakeFromHorse);
            EventHandlers["vorp_stables:MoveToHorse"] += new Action<Player, string>(MoveToHorse);

            EventHandlers["vorp_stables:UpdateInventoryHorse"] += new Action<Player>(UpdateInventoryHorse);

            //Inventory
            EventHandlers["vorp_stables:TakeFromCart"] += new Action<Player, string>(TakeFromCart);
            EventHandlers["vorp_stables:MoveToCart"] += new Action<Player, string>(MoveToCart);

            EventHandlers["vorp_stables:UpdateInventoryCart"] += new Action<Player>(UpdateInventoryCart);

            TriggerEvent("getCore", new Action<dynamic>((dic) =>
            {
                VORPCORE = dic;
            }));
        }

        private void TransferHorse([FromSource]Player source, int HorseId, int TargetId)
        {
            PlayerList pl = new PlayerList();
            Player target = pl[TargetId];

            string sid = "steam:" + target.Identifiers["steam"];
            dynamic UserCharacter = VORPCORE.getUser(TargetId).getUsedCharacter;
            int charIdentifier = UserCharacter.charIdentifier;

            Exports["ghmattimysql"].execute("UPDATE stables SET identifier=?, charidentifier=?, isDefault=0 WHERE id=?", new object[] { sid, charIdentifier, HorseId });

            BaseScript.Delay(2000);

            ReLoadStables(target);
        }

        private void UpdateInventoryHorse([FromSource]Player source)
        {
            string sid = "steam:" + source.Identifiers["steam"];
            dynamic UserCharacter = VORPCORE.getUser(int.Parse(source.Handle)).getUsedCharacter;
            int charIdentifier = UserCharacter.charIdentifier;

            Exports["ghmattimysql"].execute("SELECT * FROM stables WHERE identifier=? AND isDefault=1 AND type=? AND charidentifier=?", new object[] { sid, "horse", charIdentifier }, new Action<dynamic>((result) =>
            {
                if (result.Count != 0)
                {
                    JObject items = new JObject();

                    string inv = result[0].inventory;
                    if(String.IsNullOrEmpty(inv))
                    {
                        items.Add("itemList", "[]");
                        items.Add("action", "setSecondInventoryItems");

                        source.TriggerEvent("vorp_inventory:ReloadHorseInventory", items.ToString());
                    }
                    else
                    { 
                        JArray data = JArray.Parse(inv);
                        items.Add("itemList", data);
                        items.Add("action", "setSecondInventoryItems");

                        source.TriggerEvent("vorp_inventory:ReloadHorseInventory", items.ToString());
                    }
                }

            }));
        }

        private void UpdateInventoryCart([FromSource]Player source)
        {
            string sid = "steam:" + source.Identifiers["steam"];
            dynamic UserCharacter = VORPCORE.getUser(int.Parse(source.Handle)).getUsedCharacter;
            int charIdentifier = UserCharacter.charIdentifier;

            Exports["ghmattimysql"].execute("SELECT * FROM stables WHERE identifier=? AND isDefault=1 AND type=? AND charidentifier=?", new object[] { sid, "cart", charIdentifier }, new Action<dynamic>((result) =>
            {
                if (result.Count != 0)
                {
                    JObject items = new JObject();

                    string inv = result[0].inventory;

                    if (String.IsNullOrEmpty(inv))
                    {
                        items.Add("itemList", "[]");
                        items.Add("action", "setSecondInventoryItems");

                        source.TriggerEvent("vorp_inventory:ReloadCartInventory", items.ToString());
                    }
                    else
                    {
                        JArray data = JArray.Parse(inv);
                        items.Add("itemList", data);
                        items.Add("action", "setSecondInventoryItems");

                        source.TriggerEvent("vorp_inventory:ReloadCartInventory", items.ToString());
                    }
                }

            }));
        }

        private async void MoveToCart([FromSource]Player player, string jsondata)
        {
            string sid = "steam:" + player.Identifiers["steam"];

            dynamic UserCharacter = VORPCORE.getUser(int.Parse(player.Handle)).getUsedCharacter;
            int charIdentifier = UserCharacter.charIdentifier;

            JObject data = JObject.Parse(jsondata);

            if (String.IsNullOrEmpty(data["number"].ToString()))
            {
                return;
            }

            string type = data["item"]["type"].ToString();
            if (type.Contains("item_weapon"))
            {
                player.TriggerEvent("vorp:TipBottom", LoadConfig.Langs["WeaponsNotAllowed"], 2500);
                return;
            }

            string label = data["item"]["label"].ToString();
            string name = data["item"]["name"].ToString();

            int count = data["item"]["count"].ToObject<int>();
            int number = data["number"].ToObject<int>();

            JArray itemBlackList = JArray.Parse(LoadConfig.Config["ItemsBlacklist"].ToString());
            foreach (var ibl in itemBlackList)
            {
                if (ibl.ToString().Equals(name))
                {
                    player.TriggerEvent("vorp:TipBottom", LoadConfig.Langs["ItemInBlacklist"], 2500);
                    return;
                }
            }

            if (number > count || number < 1)
            {
                player.TriggerEvent("vorp:TipBottom", LoadConfig.Langs["ErrorQuantity"], 2500);
                return;
            }


            Exports["ghmattimysql"].execute("SELECT * FROM stables WHERE identifier=? AND isDefault=1 AND type=? AND charidentifier=?", new object[] { sid, "cart", charIdentifier }, new Action<dynamic>((result) =>
            {
                if (result.Count == 0)
                {
                    Debug.WriteLine($"Error no cart default");
                }
                else
                {
                    string inv = result[0].inventory;
                    string model = result[0].modelname;
                    int horseId = result[0].id;
                    if (!String.IsNullOrEmpty(inv))
                    {
                        JArray horseData = JArray.Parse(inv);

                        int totalWeight = 0;
                        foreach (var hd in horseData)
                        {
                            totalWeight += hd["count"].ToObject<int>();
                        }

                        int maxWeight = LoadConfig.Config["DefaultMaxWeight"].ToObject<int>();

                        foreach (JObject c in LoadConfig.Config["CustomMaxWeight"].Children<JObject>())
                        {
                            foreach (JProperty comp in c.Properties())
                            {
                                if (comp.Name.Equals(model.Trim()))
                                {
                                    maxWeight = int.Parse(comp.Value.ToString());
                                }
                            }
                        }

                        if (maxWeight < (number + totalWeight))
                        {
                            player.TriggerEvent("vorp:TipBottom", string.Format(LoadConfig.Langs["MaxWeightQuantity"], totalWeight.ToString(), maxWeight.ToString()), 2500);
                            return;
                        }

                        JToken itemFound = horseData.FirstOrDefault(x => x["name"].ToString().Equals(name));

                        if (itemFound != null)
                        {
                            int indexItem = horseData.IndexOf(itemFound);

                            horseData[indexItem]["count"] = horseData[indexItem]["count"].ToObject<int>() + number;

                            TriggerEvent("vorpCore:subItem", int.Parse(player.Handle), name, number);
                            Exports["ghmattimysql"].execute("UPDATE stables SET inventory=? WHERE identifier=? AND id=?", new object[] { horseData.ToString().Replace(Environment.NewLine, " "), sid, horseId });
                            Debug.WriteLine(horseData.ToString().Replace(Environment.NewLine, " "));
                            JObject items = new JObject();

                            items.Add("itemList", horseData);
                            items.Add("action", "setSecondInventoryItems");

                            player.TriggerEvent("vorp_inventory:ReloadCartInventory", items.ToString());

                        }
                        else
                        {
                            data["item"]["count"] = number;
                            horseData.Add(data["item"]);


                            TriggerEvent("vorpCore:subItem", int.Parse(player.Handle), name, number);
                            Exports["ghmattimysql"].execute("UPDATE stables SET inventory=? WHERE identifier=? AND id=?", new object[] { horseData.ToString().Replace(Environment.NewLine, " "), sid, horseId });

                            JObject items = new JObject();

                            items.Add("itemList", horseData);
                            items.Add("action", "setSecondInventoryItems");

                            player.TriggerEvent("vorp_inventory:ReloadCartInventory", items.ToString());
                        }
                    }
                    else
                    {
                        JArray horseData = new JArray();
                        data["item"]["count"] = number;
                        horseData.Add(data["item"]);


                        TriggerEvent("vorpCore:subItem", int.Parse(player.Handle), name, number);
                        Exports["ghmattimysql"].execute("UPDATE stables SET inventory=? WHERE identifier=? AND id=?", new object[] { horseData.ToString().Replace(Environment.NewLine, " "), sid, horseId });

                        JObject items = new JObject();

                        items.Add("itemList", horseData);
                        items.Add("action", "setSecondInventoryItems");

                        player.TriggerEvent("vorp_inventory:ReloadCartInventory", items.ToString());
                    }
                }

            }));

        }

        private async void TakeFromCart([FromSource]Player player, string jsondata)
        {
            string sid = "steam:" + player.Identifiers["steam"];

            dynamic UserCharacter = VORPCORE.getUser(int.Parse(player.Handle)).getUsedCharacter;
            int charIdentifier = UserCharacter.charIdentifier;

            JObject data = JObject.Parse(jsondata);

            if (String.IsNullOrEmpty(data["number"].ToString()))
            {
                return;
            }

            string label = data["item"]["label"].ToString();
            string name = data["item"]["name"].ToString();
            int count = data["item"]["count"].ToObject<int>();
            int limit = data["item"]["limit"].ToObject<int>();
            int number = data["number"].ToObject<int>();

            if (number <= 0)
            {
                player.TriggerEvent("vorp:TipBottom", LoadConfig.Langs["ErrorQuantity"], 2500);
                return;
            }

            TriggerEvent("vorpCore:getItemCount", int.Parse(player.Handle), new Action<dynamic>((mycount) =>
            {
                int itemc = mycount;

                if (limit < (itemc + number) && limit != -1)
                {
                    player.TriggerEvent("vorp:TipBottom", LoadConfig.Langs["ErrorQuantity"], 2500);
                    return;
                }

                Exports["ghmattimysql"].execute("SELECT * FROM stables WHERE identifier=? AND isDefault=1 AND type=? AND charidentifier=?", new object[] { sid, "cart", charIdentifier }, new Action<dynamic>((result) =>
                {
                    if (result.Count == 0)
                    {
                        Debug.WriteLine($"Error no Cart default");
                    }
                    else
                    {
                        string inv = result[0].inventory;
                        int horseId = result[0].id;
                        if (!String.IsNullOrEmpty(inv))
                        {
                            JArray horseData = JArray.Parse(inv);

                            JToken itemFound = horseData.FirstOrDefault(x => x["name"].ToString().Equals(name));

                            if (itemFound != null)
                            {
                                int indexItem = horseData.IndexOf(itemFound);

                                int newcount = horseData[indexItem]["count"].ToObject<int>() - number;

                                if (newcount < 0)
                                {
                                    player.TriggerEvent("vorp:TipBottom", LoadConfig.Langs["ErrorQuantity"], 2500);
                                    return;
                                }

                                TriggerEvent("vorpCore:canCarryItems", int.Parse(player.Handle), number, new Action<dynamic>((can) =>
                                {

                                    if (!can)
                                    {
                                        player.TriggerEvent("vorp:TipBottom", LoadConfig.Langs["ErrorQuantity"], 2500);
                                        return;
                                    }
                                    else if (newcount == 0)
                                    {
                                        horseData.RemoveAt(indexItem);
                                    }
                                    else
                                    {
                                        horseData[indexItem]["count"] = horseData[indexItem]["count"].ToObject<int>() - number;
                                    }

                                    TriggerEvent("vorpCore:addItem", int.Parse(player.Handle), name, number);
                                    Exports["ghmattimysql"].execute("UPDATE stables SET inventory=? WHERE identifier=? AND id=?", new object[] { horseData.ToString().Replace(Environment.NewLine, " "), sid, horseId });
                                    JObject items = new JObject();

                                    items.Add("itemList", horseData);
                                    items.Add("action", "setSecondInventoryItems");

                                    player.TriggerEvent("vorp_inventory:ReloadCartInventory", items.ToString());
                                }));
                            }
                            else
                            {
                                Debug.WriteLine(player.Name + "Attempt to dupe in Cart inventory");
                            }
                        }
                        else
                        {
                            Debug.WriteLine(player.Name + "Attempt to dupe in Cart inventory");
                        }
                    }

                }));

            }), name.Trim());

            //Debug.WriteLine(data["item"]["label"].ToString());
            //Debug.WriteLine(data["number"].ToString());
        }

        private async void MoveToHorse([FromSource]Player player, string jsondata)
        {
            string sid = "steam:" + player.Identifiers["steam"];

            dynamic UserCharacter = VORPCORE.getUser(int.Parse(player.Handle)).getUsedCharacter;
            int charIdentifier = UserCharacter.charIdentifier;

            JObject data = JObject.Parse(jsondata);

            if (String.IsNullOrEmpty(data["number"].ToString()))
            {
                return;
            }

            string type = data["item"]["type"].ToString();
            if (type.Contains("item_weapon"))
            {
                player.TriggerEvent("vorp:TipBottom", LoadConfig.Langs["WeaponsNotAllowed"], 2500);
                return;
            }

            string label = data["item"]["label"].ToString();
            string name = data["item"]["name"].ToString();
           
            int count = data["item"]["count"].ToObject<int>();
            int number = data["number"].ToObject<int>();
            JArray itemBlackList = JArray.Parse(LoadConfig.Config["ItemsBlacklist"].ToString());
            foreach (var ibl in itemBlackList)
            {
                if (ibl.ToString().Equals(name))
                {
                    player.TriggerEvent("vorp:TipBottom", LoadConfig.Langs["ItemInBlacklist"], 2500);
                    return;
                }
            }

            if (number > count || number < 1)
            {
                player.TriggerEvent("vorp:TipBottom", LoadConfig.Langs["ErrorQuantity"], 2500);
                return;
            }

            TriggerEvent("vorpCore:getItemCount", int.Parse(player.Handle), new Action<int>((invcount) => {
                if (invcount == count)
                {
                    Exports["ghmattimysql"].execute("SELECT * FROM stables WHERE identifier=? AND isDefault=1 AND type=? AND charidentifier=?", new object[] { sid, "horse", charIdentifier }, new Action<dynamic>((result) =>
                    {
                        if (result.Count == 0)
                        {
                            Debug.WriteLine($"Error no horse default");
                        }
                        else
                        {
                            string inv = result[0].inventory;
                            string model = result[0].modelname;
                            int horseId = result[0].id;
                            if (!String.IsNullOrEmpty(inv))
                            {
                                JArray horseData = JArray.Parse(inv);

                                int totalWeight = 0;
                                foreach (var hd in horseData)
                                {
                                    totalWeight += hd["count"].ToObject<int>();
                                }

                                int maxWeight = LoadConfig.Config["DefaultMaxWeight"].ToObject<int>();

                                foreach (JObject c in LoadConfig.Config["CustomMaxWeight"].Children<JObject>())
                                {
                                    foreach (JProperty comp in c.Properties())
                                    {
                                        if (comp.Name.Equals(model.Trim()))
                                        {
                                            maxWeight = int.Parse(comp.Value.ToString());
                                        }
                                    }
                                }

                                if (maxWeight < (number + totalWeight))
                                {
                                    player.TriggerEvent("vorp:TipBottom", string.Format(LoadConfig.Langs["MaxWeightQuantity"], totalWeight.ToString(), maxWeight.ToString()), 2500);
                                    return;
                                }

                                JToken itemFound = horseData.FirstOrDefault(x=>x["name"].ToString().Equals(name));


                                if (itemFound != null)
                                {
                                    int indexItem = horseData.IndexOf(itemFound);

                                    horseData[indexItem]["count"] = horseData[indexItem]["count"].ToObject<int>() + number;

                                    TriggerEvent("vorpCore:subItem", int.Parse(player.Handle), name, number);
                                    Exports["ghmattimysql"].execute("UPDATE stables SET inventory=? WHERE identifier=? AND id=?", new object[] { horseData.ToString().Replace(Environment.NewLine, " "), sid, horseId });
                                    Debug.WriteLine(horseData.ToString().Replace(Environment.NewLine, " "));
                                    JObject items = new JObject();

                                    items.Add("itemList", horseData);
                                    items.Add("action", "setSecondInventoryItems");

                                    player.TriggerEvent("vorp_inventory:ReloadHorseInventory", items.ToString());

                                }
                                else
                                {
                                    data["item"]["count"] = number;
                                    horseData.Add(data["item"]);

                                    TriggerEvent("vorpCore:subItem", int.Parse(player.Handle), name, number);
                                    Exports["ghmattimysql"].execute("UPDATE stables SET inventory=? WHERE identifier=? AND id=?", new object[] { horseData.ToString().Replace(Environment.NewLine, " "), sid, horseId });

                                    JObject items = new JObject();

                                    items.Add("itemList", horseData);
                                    items.Add("action", "setSecondInventoryItems");

                                    player.TriggerEvent("vorp_inventory:ReloadHorseInventory", items.ToString());
                                }
                            }
                            else
                            {
                                JArray horseData = new JArray();
                                data["item"]["count"] = number;
                                horseData.Add(data["item"]);


                                TriggerEvent("vorpCore:subItem", int.Parse(player.Handle), name, number);
                                Exports["ghmattimysql"].execute("UPDATE stables SET inventory=? WHERE identifier=? AND id=?", new object[] { horseData.ToString().Replace(Environment.NewLine, " "), sid, horseId });

                                JObject items = new JObject();

                                items.Add("itemList", horseData);
                                items.Add("action", "setSecondInventoryItems");

                                player.TriggerEvent("vorp_inventory:ReloadHorseInventory", items.ToString());
                            }

                        }

                    }));
                }
                else
                {
                    player.TriggerEvent("vorp:TipBottom", "No coincide el inventario", 10000);
                }
            }), name);

        }

        private async void TakeFromHorse([FromSource]Player player, string jsondata)
        {
            string sid = "steam:" + player.Identifiers["steam"];

            dynamic UserCharacter = VORPCORE.getUser(int.Parse(player.Handle)).getUsedCharacter;
            int charIdentifier = UserCharacter.charIdentifier;

            JObject data = JObject.Parse(jsondata);

            if (String.IsNullOrEmpty(data["number"].ToString()))
            {
                return;
            }

            string label = data["item"]["label"].ToString();
            string name = data["item"]["name"].ToString();
            int count = data["item"]["count"].ToObject<int>();
            int limit = data["item"]["limit"].ToObject<int>();
            int number = data["number"].ToObject<int>();

            if (number <= 0)
            {
                player.TriggerEvent("vorp:TipBottom", LoadConfig.Langs["ErrorQuantity"], 2500);
                return;
            }

            TriggerEvent("vorpCore:getItemCount", int.Parse(player.Handle), new Action<dynamic>((mycount) =>
            {
                int itemc = mycount;
                Debug.WriteLine(itemc.ToString());

                if (limit < (itemc + number) && limit != -1)
                {
                    player.TriggerEvent("vorp:TipBottom", LoadConfig.Langs["ErrorQuantity"], 2500);
                    return;
                }

                Exports["ghmattimysql"].execute("SELECT * FROM stables WHERE identifier=? AND isDefault=1 AND type=? AND charidentifier=?", new object[] { sid, "horse", charIdentifier }, new Action<dynamic>((result) =>
                {
                    if (result.Count == 0)
                    {
                        Debug.WriteLine($"Error no horse default");
                    }
                    else
                    {
                        string inv = result[0].inventory;
                        int horseId = result[0].id;
                        if (!String.IsNullOrEmpty(inv))
                        {
                            JArray horseData = JArray.Parse(inv);

                            JToken itemFound = horseData.FirstOrDefault(x => x["name"].ToString().Equals(name));

                            if (itemFound != null)
                            {
                                int indexItem = horseData.IndexOf(itemFound);

                                int newcount = horseData[indexItem]["count"].ToObject<int>() - number;

                                if (newcount < 0)
                                {
                                    player.TriggerEvent("vorp:TipBottom", LoadConfig.Langs["ErrorQuantity"], 2500);
                                    return;
                                }

                                TriggerEvent("vorpCore:canCarryItems", int.Parse(player.Handle), number, new Action<dynamic>((can) =>
                                {

                                    if (!can)
                                    {
                                        player.TriggerEvent("vorp:TipBottom", LoadConfig.Langs["ErrorQuantity"], 2500);
                                        return;
                                    }
                                    else if (newcount == 0)
                                    {
                                        horseData.RemoveAt(indexItem);
                                    }
                                    else
                                    {
                                        horseData[indexItem]["count"] = horseData[indexItem]["count"].ToObject<int>() - number;
                                    }

                                    TriggerEvent("vorpCore:addItem", int.Parse(player.Handle), name, number);
                                    Exports["ghmattimysql"].execute("UPDATE stables SET inventory=? WHERE identifier=? AND id=?", new object[] { horseData.ToString().Replace(Environment.NewLine, " "), sid, horseId });
                                    Debug.WriteLine(horseData.ToString().Replace(Environment.NewLine, " "));
                                    JObject items = new JObject();

                                    items.Add("itemList", horseData);
                                    items.Add("action", "setSecondInventoryItems");

                                    player.TriggerEvent("vorp_inventory:ReloadHorseInventory", items.ToString());
                                }));

                            }
                            else
                            {
                                Debug.WriteLine(player.Name + "Attempt to dupe in horse inventory");
                            }
                        }
                        else
                        {
                            Debug.WriteLine(player.Name + "Attempt to dupe in horse inventory");
                        }
                    }

                }));

            }), name.Trim());

            //Debug.WriteLine(data["item"]["label"].ToString());
            //Debug.WriteLine(data["number"].ToString());
        }

        private void UpdateComp([FromSource]Player source, string jgear, int horseId)
        {
            string sid = "steam:" + source.Identifiers["steam"];
            Exports["ghmattimysql"].execute("UPDATE stables SET gear=? WHERE identifier=? AND id=?", new object[] { jgear, sid, horseId });
            Delay(2200);
            Debug.WriteLine("UpdateComp");
            ReLoadStables(source);

        }

        private void BuyNewComp([FromSource]Player source, string jcomps, double cost, string jgear, int horseId)
        {
            string sid = "steam:" + source.Identifiers["steam"];
            int _source = int.Parse(source.Handle);

            dynamic UserCharacter = VORPCORE.getUser(_source).getUsedCharacter;
            int charIdentifier = UserCharacter.charIdentifier;

            TriggerEvent("vorp:getCharacter", _source, new Action<dynamic>((user) =>
            {
                double money = user.money;

                if (cost <= money)
                {
                    TriggerEvent("vorp:removeMoney", _source, 0, cost);
                    Exports["ghmattimysql"].execute("SELECT * FROM horse_complements WHERE identifier=? AND charidentifier=?", new object[] { sid, charIdentifier }, new Action<dynamic>((result) =>
                    {
                        if (result.Count == 0)
                        {
                            Exports["ghmattimysql"].execute("INSERT INTO horse_complements (`identifier`, `charidentifier`, `complements`) VALUES (?, ?, ?)", new object[] { sid, charIdentifier, jcomps });
                            Exports["ghmattimysql"].execute("UPDATE stables SET gear=? WHERE identifier=? AND id=?", new object[] { jgear, sid, horseId });
                        }
                        else
                        {
                            Exports["ghmattimysql"].execute("UPDATE horse_complements SET complements=? WHERE identifier=? AND charidentifier=?", new object[] { jcomps, sid, charIdentifier });
                            Exports["ghmattimysql"].execute("UPDATE stables SET gear=? WHERE identifier=? AND id=?", new object[] { jgear, sid, horseId });
                        }

                    }));
                    source.TriggerEvent("vorp:TipRight", string.Format(LoadConfig.Langs["SuccessfulBuyComp"], cost), 4000);
                    ReLoadStables(source);
                }
                else
                {
                    source.TriggerEvent("vorp:TipRight", LoadConfig.Langs["NoMoney"], 4000);
                    ReLoadStables(source);
                }

            }));


        }

        private async Task ReLoadStables(Player source)
        {
            string sid = "steam:" + source.Identifiers["steam"];

            dynamic UserCharacter = VORPCORE.getUser(int.Parse(source.Handle)).getUsedCharacter;
            int charIdentifier = UserCharacter.charIdentifier;

            await Delay(4000);
            Exports["ghmattimysql"].execute("SELECT * FROM stables WHERE identifier=? AND charidentifier=?", new object[] { sid, charIdentifier }, new Action<dynamic>((result) =>
            {
                if (result.Count == 0)
                {
                    Debug.WriteLine($"{source.Name} has no horses");
                }
                else
                {
                    List<dynamic> stable = new List<dynamic>();
                    foreach (var h in result)
                    {
                        stable.Add(h);
                    }

                    source.TriggerEvent("vorpstables:GetMyStables", stable);
                    Debug.WriteLine($"Loaded {result.Count} horses of {source.Name}");
                }

            }));

            Exports["ghmattimysql"].execute("SELECT * FROM horse_complements WHERE identifier=? AND charidentifier=?", new object[] { sid, charIdentifier }, new Action<dynamic>((result) =>
            {
                if (result.Count == 0)
                {
                    Debug.WriteLine($"{source.Name} has no complements");
                }
                else
                {
                    string complements = result[0].complements;
                    source.TriggerEvent("vorpstables:GetMyComplements", complements);
                }
            }));
        }

        private void SetDefaultHorse([FromSource]Player source, int horseId)
        {
            string sid = "steam:" + source.Identifiers["steam"];

            dynamic UserCharacter = VORPCORE.getUser(int.Parse(source.Handle)).getUsedCharacter;
            int charIdentifier = UserCharacter.charIdentifier;

            Exports["ghmattimysql"].execute("UPDATE stables SET isDefault=0 WHERE identifier=? AND NOT id=? AND type=? AND charidentifier=?", new object[] { sid, horseId, "horse", charIdentifier });
            Exports["ghmattimysql"].execute("UPDATE stables SET isDefault=1 WHERE identifier=? AND id=?", new object[] { sid, horseId });
        }

        private void RemoveHorse([FromSource]Player source, int horseId)
        {
            string sid = "steam:" + source.Identifiers["steam"];

            Exports["ghmattimysql"].execute("DELETE FROM stables WHERE identifier=? AND id=?", new object[] { sid, horseId });
        }

        private void SetDefaultCart([FromSource]Player source, int horseId)
        {
            string sid = "steam:" + source.Identifiers["steam"];

            dynamic UserCharacter = VORPCORE.getUser(int.Parse(source.Handle)).getUsedCharacter;
            int charIdentifier = UserCharacter.charIdentifier;

            Exports["ghmattimysql"].execute("UPDATE stables SET isDefault=0 WHERE identifier=? AND NOT id=? AND type=? AND charidentifier=?", new object[] { sid, horseId, "cart", charIdentifier });
            Exports["ghmattimysql"].execute("UPDATE stables SET isDefault=1 WHERE identifier=? AND id=?", new object[] { sid, horseId });
        }

        private void BuyNewHorse([FromSource]Player source, string name, string race, string model, double cost)
        {
            int _source = int.Parse(source.Handle);

            string sid = "steam:" + source.Identifiers["steam"];

            dynamic UserCharacter = VORPCORE.getUser(_source).getUsedCharacter;
            int charIdentifier = UserCharacter.charIdentifier;
          
            double money = UserCharacter.money;

            if (cost <= money)
            {
                UserCharacter.removeCurrency(0, cost);
                Exports["ghmattimysql"].execute("INSERT INTO stables (`identifier`, `charidentifier`, `name`, `type`, `modelname`) VALUES (?, ?, ?, ?, ?)", new object[] { sid, charIdentifier, name, "horse", model });
                source.TriggerEvent("vorp:TipRight", string.Format(LoadConfig.Langs["SuccessfulBuyHorse"], name, cost.ToString()), 4000);
                Delay(2200);
                ReLoadStables(source);
            }
            else
            {
                source.TriggerEvent("vorp:TipRight", LoadConfig.Langs["NoMoney"], 4000);
            }

        }

        private void BuyNewCart([FromSource]Player source, string name, string model, double cost)
        {
            int _source = int.Parse(source.Handle);

            string sid = "steam:" + source.Identifiers["steam"];

            dynamic UserCharacter = VORPCORE.getUser(_source).getUsedCharacter;
            int charIdentifier = UserCharacter.charIdentifier;

            double money = UserCharacter.money;
             
            if (cost <= money)
            {
                UserCharacter.removeCurrency(0, cost);
                Exports["ghmattimysql"].execute("INSERT INTO stables (`identifier`, `charidentifier`, `name`, `type`, `modelname`) VALUES (?, ?, ?, ?, ?)", new object[] { sid, charIdentifier, name, "cart", model });
                source.TriggerEvent("vorp:TipRight", string.Format(LoadConfig.Langs["SuccessfulBuyHorse"], name, cost.ToString()), 4000);
                Delay(2200); 
                ReLoadStables(source);
            }
            else
            {
                source.TriggerEvent("vorp:TipRight", LoadConfig.Langs["NoMoney"], 4000);
            }

        }
    }
}
