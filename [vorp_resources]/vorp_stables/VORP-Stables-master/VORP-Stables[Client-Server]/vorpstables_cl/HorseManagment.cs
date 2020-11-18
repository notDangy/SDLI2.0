using CitizenFX.Core;
using CitizenFX.Core.Native;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace vorpstables_cl
{
    public class HorseManagment : BaseScript
    {
        public static List<Horse> MyHorses = new List<Horse>();
        public static List<Cart> MyCarts = new List<Cart>();
        public static List<uint> MyComps = new List<uint>();
        public static Tuple<int, Horse> spawnedHorse;
        public static Tuple<int, Cart> spawnedCart;
        public static int MPTagHorse = 0;
        public static bool horsespawned = false;

        List<Vector3> scuderie = new List<Vector3> {
            new Vector3(-385.4f,761.1f, 115.6f),
            new Vector3(-877.8f,-1392.0f, 43.8f),
            new Vector3(2503.4f,-1430.4f, 46.2f),
            new Vector3(-5551.7f,-3017f, -1.3f),
            new Vector3(2957.9f,1434.5f, 45.1f),
            new Vector3(-1822.5f,-603.0f, 314.6f),
        };

        public HorseManagment()
        {
            EventHandlers["vorpstables:GetMyStables"] += new Action<List<dynamic>>(GetMyStables);
            EventHandlers["vorpstables:GetMyComplements"] += new Action<string>(GetMyComplements);

            EventHandlers["vorp:SelectedCharacter"] += new Action<int>((charId) => { TriggerServerEvent("vorpstables:LoadMyStables"); });
            
            Tick += onCallHorse;
            Tick += onHorseDead;
            Tick += timeToRespawn;
            Tick += destroyCarts;

        }

        [Tick]
        public async Task destroyCarts()
        {



            Vector3 playerCoords = API.GetEntityCoords(API.PlayerPedId(), true, true);

            foreach (var item in scuderie)
            {

                if (API.GetDistanceBetweenCoords(playerCoords.X, playerCoords.Y, playerCoords.Z, item.X, item.Y, item.Z, true) < 2.0f)
                {

                    await DrawTxt("Premi [J] per ritirare il carro, premi [G] per depositarlo", 0.5f, 0.9f, 0.7f, 0.7f, 255, 255, 255, 255, true, true);

                    if (API.IsControlJustPressed(0, 0x63A0D258))
                    {

                        int vehicle = API.GetVehiclePedIsIn(API.PlayerPedId(), false);
                        API.SetEntityAsMissionEntity(vehicle, true, true);
                        API.DeleteVehicle(ref vehicle);
                        await Delay(5000); // Anti Flood
                    }
                }
            }


        }

        [Tick]
        private async Task drawBlipsScuderie()
        {
            await Delay(10000);
            foreach (var item in scuderie)
            {
                int _blip = Function.Call<int>((Hash)0x554D9D53F696D002, (uint)1664425300, item.X, item.Y, item.Z);
                Function.Call((Hash)0x74F74D3207ED525C, _blip, 1012165077, 1);
                Function.Call((Hash)0x9CB1A1623062F402, _blip, "Scuderia");
            }

        }

        [Tick]
        private async Task timeToRespawn()
        {
            for (int h = 0; h < MyHorses.Count(); h++)
            {
                if (MyHorses[h].getHorseDeadTime() > 0)
                {
                    MyHorses[h].setHorseDead(MyHorses[h].getHorseDeadTime() - 1);
                }
            }
            await Delay(1000);
        }

        [Tick]
        private async Task onHorseDead()
        {

            if (spawnedHorse == null || spawnedHorse.Item1 == -1) 
            {

            }
            else 
            {
                if (!API.IsEntityDead(spawnedHorse.Item1) && API.DoesEntityExist(spawnedHorse.Item1) && horsespawned)
                {
                    int health = Function.Call<int>((Hash)0x36731AC041289BB1, spawnedHorse.Item1, 0);
                    health += Function.Call<int>((Hash)0x82368787EA73C0F7, spawnedHorse.Item1);
                    spawnedHorse.Item2.status["Health"] = health;

                    int staminaInner = Function.Call<int>((Hash)0x36731AC041289BB1, spawnedHorse.Item1, 1);
                    spawnedHorse.Item2.status["Stamina"] = staminaInner;

                }


                if (API.IsEntityDead(spawnedHorse.Item1) && spawnedHorse.Item2.getHorseDeadTime() == 0 && API.DoesEntityExist(spawnedHorse.Item1))
                {
                    int indexHorse = MyHorses.IndexOf(spawnedHorse.Item2);
                    spawnedHorse.Item2.setHorseDead(GetConfig.Config["SecondsToRespawn"].ToObject<int>());
                    MyHorses[indexHorse].setHorseDead(GetConfig.Config["SecondsToRespawn"].ToObject<int>());
                    TriggerEvent("vorp:Tip", string.Format(GetConfig.Langs["HorseDead"], spawnedHorse.Item2.getHorseName(), spawnedHorse.Item2.getHorseDeadTime()), 5000);
                    int pedHorse = spawnedHorse.Item1;
                    API.DeletePed(ref pedHorse);
                }
            }

            await Delay(1000);

        }

        public static void SetDefaultCartDB(int id)
        {
            TriggerServerEvent("vorpstables:SetDefaultCart", id);
        }

        private void GetMyComplements(string comps)
        {
            MyComps.Clear();
            JArray jComps = JArray.Parse(comps);
            foreach(var jc in jComps)
            {
                MyComps.Add(ConvertValue(jc.ToString()));
            }
        }

        public static bool isLoading = false;

        [Tick]
        private async Task onCallHorse()
        {
            int pedAiming = 0;

            if (API.IsControlJustPressed(0, 0x24978A28) && !isLoading)
            {
                CallHorse();
                await Delay(5000); // Anti Flood
            }

            if (API.IsControlPressed(0, 0xE16B9AAD))
            {
                if(API.IsControlPressed(0, 0xD9D0E1C0))
                {
                    Random rnd = new Random();
                    if (rnd.Next(0, 100) > GetConfig.Config["HorseSkillPullUpFailPercent"].ToObject<int>())
                    {
                        Function.Call((Hash)0xA09CFD29100F06C3, API.GetMount(API.PlayerPedId()), 1, 0, 0);
                    }
                    else
                    {
                        Function.Call((Hash)0xA09CFD29100F06C3, API.GetMount(API.PlayerPedId()), 2, 0, 0);
                    }
                    await Delay(6000);
                }
            }

            if (API.IsControlJustPressed(0, 0xF3830D8E) && !isLoading)
            {

                //Function.Call((Hash)0xCD181A959CFDD7F4, API.PlayerPedId(), spawnedHorse.Item1, -224471938, -118748546, 0);
                //Function.Call((Hash)0xCD181A959CFDD7F4, API.PlayerPedId(), spawnedHorse.Item1, 1968415774, API.GetHashKey("s_horseointment01x"), 0);
                //Function.Call((Hash)0xCD181A959CFDD7F4, API.PlayerPedId(), spawnedHorse.Item1, 554992710, API.GetHashKey("p_brushhorse01x"), 0);
                //Function.Call((Hash)0xCD181A959CFDD7F4, API.PlayerPedId(), spawnedHorse.Item1, 554992710, API.GetHashKey("p_brushhorse01x"), 0); 0xD8F73058
                Vector3 playerCoords = API.GetEntityCoords(API.PlayerPedId(), true, true);

                foreach (var item in scuderie)

                {
                    if (API.GetDistanceBetweenCoords(playerCoords.X, playerCoords.Y, playerCoords.Z, item.X, item.Y, item.Z, true) < 2.0f)
                    {
                        CallCart();
                        await Delay(5000); // Anti Flood
                    }
                }
            }

            if (API.IsControlJustPressed(0, 0xD8F73058))
            {
                if (spawnedHorse != null)
                {
                    if (spawnedHorse.Item1 != -1 && API.DoesEntityExist(spawnedHorse.Item1))
                    {
                        float distance = getHorseDistance(spawnedHorse.Item1);
                        if (distance <= 1.0F)
                        {
                            TriggerEvent("vorp_inventory:OpenHorseInventory", spawnedHorse.Item2.getHorseName());
                            TriggerServerEvent("vorp_stables:UpdateInventoryHorse");
                        }
                    }
                }
                if (spawnedCart != null)
                {
                    if (spawnedCart.Item1 != -1 && API.DoesEntityExist(spawnedCart.Item1))
                    {

                        float distance = getHorseDistance(spawnedCart.Item1);
                        Debug.WriteLine(distance.ToString());
                        if (distance <= 5.0F)
                        {
                            TriggerEvent("vorp_inventory:OpenCartInventory", spawnedCart.Item2.getHorseName());
                            TriggerServerEvent("vorp_stables:UpdateInventoryCart");
                        }

                    }
                }

                await Delay(1000); // Anti Flood 
            }

            if (API.GetEntityPlayerIsFreeAimingAt(API.PlayerId(), ref pedAiming) && API.IsDisabledControlJustPressed(0, 0x4216AF06))
            {
                FleeHorse(pedAiming);
                await Delay(1000);
            }

            if (API.IsDisabledControlJustPressed(0, 0x63A38F2C))
            {
                int targetped = pedAiming;
                Function.Call((Hash)0xCD181A959CFDD7F4, API.PlayerPedId(), spawnedHorse.Item1, 554992710, API.GetHashKey("p_brushhorse01x"), 0);
                await Delay(7000);
                API.ClearPedEnvDirt(targetped);
                API.ClearPedBloodDamage(targetped);
                API.ClearPedDecorations(targetped);
                API.ClearPedWetness(targetped);
            }

        }

        private async Task FleeHorse(int ped)
        {

            if (ped == spawnedHorse.Item1)
            {
                Vector3 pedCoords = API.GetEntityCoords(API.PlayerPedId(), true, true);
                //Function.Call((Hash)0x94587F17E9C365D5, pedAiming, pedCoords.X + 10.0f, pedCoords.Y + 10.0f, pedCoords.Z, 1.0f, 10000, false, true); FEATURE
                Function.Call((Hash)0xA899B61C66F09134, ped, 0, 0);
                API.TaskGoToCoordAnyMeans(ped, pedCoords.X + 20.0f, pedCoords.Y + 20.0f, pedCoords.Z, 3.0F, 0, true, 0, 1.0f);
                await Delay(4000);
                API.DeletePed(ref ped);
                horsespawned = false;
            }
        }

        [Tick]
        private async Task onTagHorse()
        {
            await Delay(1000);
            if (spawnedHorse != null && API.DoesEntityExist(spawnedHorse.Item1))
            {
                if (getHorseDistance(spawnedHorse.Item1) < 15.0f && Function.Call<bool>((Hash)0xAAB0FE202E9FC9F0, spawnedHorse.Item1, -1))
                {
                    Function.Call((Hash)0x93171DDDAB274EB8, MPTagHorse, 2);
                }
                else
                {
                    if (API.IsMpGamerTagActive(MPTagHorse))
                    {
                        Function.Call((Hash)0x93171DDDAB274EB8, MPTagHorse, 0);
                    }
                }
            }

        }

        public async Task<bool> GetControlOfEntity(int entity)
        {
            API.NetworkRequestControlOfEntity(entity);
            API.SetEntityAsMissionEntity(entity, true, true);

            int timeout = 2000;

            while (timeout > 0 && !API.NetworkHasControlOfEntity(entity))
            {
                await Delay(100);
                timeout -= 100;
            }

            return API.NetworkHasControlOfEntity(entity);
        }

        private async Task CallHorse()
        {
            if (spawnedHorse != null)
            {
                if (API.DoesEntityExist(spawnedHorse.Item1) && spawnedHorse.Item1 != -1) // if spawned
                {
                    if (Function.Call<bool>((Hash)0xAAB0FE202E9FC9F0, spawnedHorse.Item1, -1))
                    {
                        if (getHorseDistance(spawnedHorse.Item1) < GetConfig.Config["DistanceToTeleport"].ToObject<float>())
                        {
                            int pPID = API.PlayerPedId();
                            await GetControlOfEntity(spawnedHorse.Item1);
                            Function.Call((Hash)0x6A071245EB0D1882, spawnedHorse.Item1, pPID, -1, 5.0F, 2.0F, 0F, 0);
                        }
                        else
                        {
                            await GetControlOfEntity(spawnedHorse.Item1);
                            int pPID = API.PlayerPedId();
                            Vector3 playerPos = API.GetEntityCoords(pPID, true, true);

                            Vector3 spawnPos = Vector3.Zero;
                            Vector3 spawnPos2 = Vector3.Zero;
                            float spawnHeading = 0.0F;
                            int unk1 = 0;

                            API.GetClosestRoad(playerPos.X + 10.0f, playerPos.Y + 10.0f, playerPos.Z, 0.0f, 25, ref spawnPos, ref spawnPos2, ref unk1, ref unk1, ref spawnHeading, true);

                            if (API.GetDistanceBetweenCoords(playerPos.X, playerPos.Y, playerPos.Z, spawnPos.X, spawnPos.Y, spawnPos.Z, false) > 25.0f)
                            {
                                spawnPos.X = playerPos.X + 10.0f;
                                spawnPos.Y = playerPos.Y + 10.0f;
                                spawnPos.Z = playerPos.Z + 1.5f;
                            }

                            API.SetEntityCoords(spawnedHorse.Item1, spawnPos.X, spawnPos.Y, spawnPos.Z, false, false, false, false);
                        }
                    }
                    else
                    {
                        TriggerEvent("vorp:Tip", GetConfig.Langs["HorseIsOcuppied"], 2000);
                    }
                
                }
                else
                {
                    if (spawnedHorse.Item2.getHorseDeadTime() > 0)
                    {
                        TriggerEvent("vorp:Tip", string.Format(GetConfig.Langs["HorseIsDead"], spawnedHorse.Item2.getHorseName(), spawnedHorse.Item2.getHorseDeadTime()), 5000);
                    }
                    else
                    {
                        await SpawnHorseDefault();
                    }
                    
                }
            }
            else
            {
                TriggerEvent("vorp:Tip", GetConfig.Langs["NoDefaultHorses"], 2000);
            }
        }

        private async Task CallCart()
        {
            if (spawnedCart != null)
            {
                if (API.DoesEntityExist(spawnedCart.Item1) && spawnedCart.Item1 != -1) // if spawned
                {
                    Debug.WriteLine(Function.Call<bool>((Hash)0xE052C1B1CAA4ECE4, spawnedCart.Item1, -1).ToString());

                    if (Function.Call<bool>((Hash)0xE052C1B1CAA4ECE4, spawnedCart.Item1, -1))
                    {
                        if (getHorseDistance(spawnedCart.Item1) < 30.0f)
                        {
                            int pPID = API.PlayerPedId();
                            API.NetworkRequestControlOfEntity(spawnedCart.Item1);
                            API.SetEntityAsMissionEntity(spawnedCart.Item1, true, true);

                            Function.Call((Hash)0x6A071245EB0D1882, spawnedCart.Item1, pPID, -1, 5.0F, 2.0F, 0F, 0);
                        }
                        else
                        {
                            API.NetworkRequestControlOfEntity(spawnedCart.Item1);
                            API.SetEntityAsMissionEntity(spawnedCart.Item1, true, true);
                            int hped = spawnedCart.Item1;
                            API.DeleteVehicle(ref hped);
                            await SpawnCartDefault();
                        }
                    }
                    else
                    {
                        TriggerEvent("vorp:Tip", GetConfig.Langs["CartIsOcuppied"], 2000);
                    }

                }
                else
                {
                    if (spawnedCart.Item2.getHorseDeadTime() > 0)
                    {
                        TriggerEvent("vorp:Tip", string.Format(GetConfig.Langs["CartIsDead"], spawnedCart.Item2.getHorseName(), spawnedCart.Item2.getHorseDeadTime().ToString()), 5000);
                    }
                    else
                    {
                        await SpawnCartDefault();
                    }

                }
            }
            else
            {
                TriggerEvent("vorp:Tip", GetConfig.Langs["NoDefaultCarts"], 2000);
            }
        }

        private async Task SpawnHorseDefault()
        {
            Horse def = spawnedHorse.Item2;

            uint hashHorse = (uint)API.GetHashKey(def.getHorseModel());
            await InitStables.LoadModel(hashHorse);
            int pPID = API.PlayerPedId();
            Vector3 playerPos = API.GetEntityCoords(pPID, true, true);


            Vector3 spawnPos = Vector3.Zero;
            Vector3 spawnPos2 = Vector3.Zero;
            float spawnHeading = 0.0F;
            int unk1 = 0;

            //API.GetNthClosestVehicleNodeWithHeading(playerPos.X, playerPos.Y, playerPos.Z, 25, ref spawnPos, ref spawnHeading, ref unk1, 0, 0f, 0f);

            API.GetClosestRoad(playerPos.X + 10.0f, playerPos.Y + 10.0f, playerPos.Z, 0.0f, 25, ref spawnPos, ref spawnPos2, ref unk1, ref unk1, ref spawnHeading, true);

            if(API.GetDistanceBetweenCoords(playerPos.X, playerPos.Y, playerPos.Z, spawnPos.X, spawnPos.Y, spawnPos.Z, false) > 25.0f)
            {
                spawnPos.X = playerPos.X + 10.0f;
                spawnPos.Y = playerPos.Y + 10.0f;
                spawnPos.Z = playerPos.Z + 1.0f;
            }

            int spawnedh = API.CreatePed(hashHorse, spawnPos.X, spawnPos.Y, spawnPos.Z, spawnHeading, true, true, false, false);

            Function.Call((Hash)0x283978A15512B2FE, spawnedh, true);
            Function.Call((Hash)0x23F74C2FDA6E7C61, -1230993421, spawnedh);
            Function.Call((Hash)0x6A071245EB0D1882, spawnedh, pPID, 4000, 5.0F, 2.0F, 0F, 0);
            Function.Call((Hash)0x98EFA132A4117BE1, spawnedh, def.getHorseName());
            Function.Call((Hash)0x4A48B6E03BABB4AC, spawnedh, def.getHorseName());

            uint hashP = (uint)API.GetHashKey("PLAYER");
            Function.Call((Hash)0xADB3F206518799E8, spawnedh, hashP);
            Function.Call((Hash)0xCC97B29285B1DC3B, spawnedh, 1);

            JObject gear = def.getGear();
            uint blanket = ConvertValue(gear["blanket"].ToString());
            uint saddle = ConvertValue(gear["saddle"].ToString());
            uint mane = ConvertValue(gear["mane"].ToString());
            uint tail = ConvertValue(gear["tail"].ToString());
            uint bag = ConvertValue(gear["bag"].ToString());
            uint bedroll = ConvertValue(gear["bedroll"].ToString());
            uint stirrups = ConvertValue(gear["stirrups"].ToString());
            uint horn = ConvertValue(gear["horn"].ToString());
            uint lantern = ConvertValue(gear["lantern"].ToString());
            uint mask = ConvertValue(gear["mask"].ToString());

            if (blanket != -1)
                Function.Call((Hash)0xD3A7B003ED343FD9, spawnedh, blanket, true, true, true);
            if (saddle != -1)
                Function.Call((Hash)0xD3A7B003ED343FD9, spawnedh, saddle, true, true, true);
            if (mane != -1)
                Function.Call((Hash)0xD3A7B003ED343FD9, spawnedh, mane, true, true, true);
            if (tail != -1)
                Function.Call((Hash)0xD3A7B003ED343FD9, spawnedh, tail, true, true, true);
            if (bag != -1)
                Function.Call((Hash)0xD3A7B003ED343FD9, spawnedh, bag, true, true, true);
            if (bedroll != -1)
                Function.Call((Hash)0xD3A7B003ED343FD9, spawnedh, bedroll, true, true, true);
            if (stirrups != -1)
                Function.Call((Hash)0xD3A7B003ED343FD9, spawnedh, stirrups, true, true, true);
            if (horn != -1)
                Function.Call((Hash)0xD3A7B003ED343FD9, spawnedh, horn, true, true, true);
            if (lantern != -1)
                Function.Call((Hash)0xD3A7B003ED343FD9, spawnedh, lantern, true, true, true);
            if (mask != -1)
                Function.Call((Hash)0xD3A7B003ED343FD9, spawnedh, mask, true, true, true);

            //NoHair
            if (mane == 1)
                Function.Call((Hash)0xD710A5007C2AC539, spawnedh, 0xAA0217AB, 0);
            if (tail == 1)
                Function.Call((Hash)0xD710A5007C2AC539, spawnedh, 0xA63CAE10, 0);

            //Create Tag
            MPTagHorse = Function.Call<int>((Hash)0xE961BF23EAB76B12, spawnedh, def.getHorseName());//Function.Call<int>((Hash)0x53CB4B502E1C57EA, spawnedh, def.getHorseName(), false, false, "", 0);
            Function.Call((Hash)0x5F57522BC1EB9D9D, MPTagHorse, API.GetHashKey("PLAYER_HORSE"));
            Function.Call((Hash)0xA0D7CE5F83259663, MPTagHorse, " ");

            spawnedHorse = new Tuple<int, Horse>(spawnedh, def);

            Function.Call((Hash)0xFE26E4609B1C3772, spawnedh, "HorseCompanion", true);

            Function.Call((Hash)0xA691C10054275290, API.PlayerPedId(), spawnedh, 0);
            Function.Call((Hash)0x931B241409216C1F, API.PlayerPedId(), spawnedh, 0);
            Function.Call((Hash)0xED1C764997A86D5A, API.PlayerPedId(), spawnedh);


            Function.Call((Hash)0xB8B6430EAD2D2437, spawnedh, 130495496);

            Function.Call((Hash)0xDF93973251FB2CA5, API.GetEntityModel(spawnedh), 1);

            Function.Call((Hash)0xAEB97D84CDF3C00B, spawnedh, 0);

            Function.Call((Hash)0x1913FE4CBF41C463, spawnedh, 211, true);
            Function.Call((Hash)0x1913FE4CBF41C463, spawnedh, 208, true);
            Function.Call((Hash)0x1913FE4CBF41C463, spawnedh, 209, true);
            Function.Call((Hash)0x1913FE4CBF41C463, spawnedh, 400, true);
            Function.Call((Hash)0x1913FE4CBF41C463, spawnedh, 297, true);
            Function.Call((Hash)0x1913FE4CBF41C463, spawnedh, 136, false);
            Function.Call((Hash)0x1913FE4CBF41C463, spawnedh, 312, false);
            Function.Call((Hash)0x1913FE4CBF41C463, spawnedh, 113, false);
            Function.Call((Hash)0x1913FE4CBF41C463, spawnedh, 301, false);
            Function.Call((Hash)0x1913FE4CBF41C463, spawnedh, 277, true);
            Function.Call((Hash)0x1913FE4CBF41C463, spawnedh, 319, true);
            Function.Call((Hash)0x1913FE4CBF41C463, spawnedh, 6, true);

            Function.Call((Hash)0x9FF1E042FA597187, spawnedh, 25, false);
            Function.Call((Hash)0x9FF1E042FA597187, spawnedh, 24, false);
            Function.Call((Hash)0x9FF1E042FA597187, spawnedh, 48, false);

            //Function.Call((Hash)0xA09CFD29100F06C3, spawnedh, 2, 0, 0);

            Function.Call((Hash)0xA691C10054275290, spawnedh, API.PlayerId(), 431);

            Function.Call((Hash)0x6734F0A6A52C371C, API.PlayerId(), 431);
            Function.Call((Hash)0x024EC9B649111915, spawnedh, 1);
            Function.Call((Hash)0xEB8886E1065654CD, spawnedh, 10, "ALL", 10f);

            API.SetModelAsNoLongerNeeded(hashHorse);


            if (def.status.ContainsKey("Health"))
            {
                if (def.status["Health"].ToObject<int>() >= 100)
                {
                    Function.Call((Hash)0xC6258F41D86676E0, spawnedh, 0, 100);
                    int lesshealth = def.status["Health"].ToObject<int>() - 100;
                    Function.Call((Hash)0xAC2767ED8BDFAB15, spawnedh, lesshealth, 0);
                }
                else
                {
                    Function.Call((Hash)0xC6258F41D86676E0, spawnedh, 0, def.status["Health"].ToObject<int>());
                }
            }

            if (def.status.ContainsKey("Stamina"))
            {
                Function.Call((Hash)0xC6258F41D86676E0, spawnedh, 1, def.status["Stamina"].ToObject<int>());
            }

            horsespawned = true;
        }

        private async Task SpawnCartDefault()
        {

            Cart def = spawnedCart.Item2;

            uint hashCart = (uint)API.GetHashKey(def.getHorseModel());
            await InitStables.LoadModel(hashCart);
            int pPID = API.PlayerPedId();
            Vector3 playerPos = API.GetEntityCoords(pPID, true, true);


            Vector3 spawnPos = playerPos;
            Vector3 spawnPos2 = Vector3.Zero;
            float spawnHeading = 0.0F;
            int unk1 = 0;

            //API.GetClosestRoad(playerPos.X + 10.0f, playerPos.Y + 10.0f, playerPos.Z, 0.0f, 25, ref spawnPos, ref spawnPos2, ref unk1, ref unk1, ref spawnHeading, true);

            int spawnedh = Function.Call<int>((Hash)0xAF35D0D2583051B0, hashCart, spawnPos.X, spawnPos.Y, spawnPos.Z, spawnHeading, true, true, false, true);
            API.SetPedIntoVehicle(API.PlayerPedId(), spawnedh, -1);

            SET_PED_DEFAULT_OUTFIT(spawnedh);

            //Function.Call((Hash)0x283978A15512B2FE, spawnedh, true);

            await Delay(1000);

            Function.Call((Hash)0x23F74C2FDA6E7C61, -1236452613, spawnedh);
            Function.Call((Hash)0x6A071245EB0D1882, spawnedh, pPID, 4000, 5.0F, 2.0F, 0F, 0);
            Function.Call((Hash)0x98EFA132A4117BE1, spawnedh, def.getHorseName());
            Function.Call((Hash)0x4A48B6E03BABB4AC, spawnedh, def.getHorseName());

            uint hashP = (uint)API.GetHashKey("PLAYER");
            Function.Call((Hash)0xADB3F206518799E8, spawnedh, hashP);
            Function.Call((Hash)0xCC97B29285B1DC3B, spawnedh, 1);

            spawnedCart = new Tuple<int, Cart>(spawnedh, def);

            //Function.Call((Hash)0x931B241409216C1F, API.PlayerPedId(), spawnedh, 0); //Brush

            API.SetModelAsNoLongerNeeded(hashCart);
        }

        public int SET_PED_DEFAULT_OUTFIT(int coach)
        {
            return Function.Call<int>((Hash)0xAF35D0D2583051B0, coach, true);
        }

        public static uint ConvertValue(string s)
        {
            uint result;

            if (uint.TryParse(s, out result))
            {
                return result;
            }
            else
            {
                int eresante = int.Parse(s);
                result = (uint)eresante;
                return result;
            }
        }

        public static void SetDefaultHorseDB(int id)
        {
            TriggerServerEvent("vorpstables:SetDefaultHorse", id);
        }

        public async static Task DeleteDefaultHorse()
        {
            if (spawnedHorse != null && spawnedHorse.Item1 !=-1)
            {
                int timeout = 0;
                int horsePed = spawnedHorse.Item1;
                API.NetworkRequestControlOfEntity(horsePed);
                API.SetEntityAsMissionEntity(horsePed, true, true);

                while (API.DoesEntityExist(horsePed) && timeout < 10)
                {
                    API.DeletePed(ref horsePed);
                    API.DeleteEntity(ref horsePed);

                    if (!API.DoesEntityExist(horsePed))
                    {
                        Debug.WriteLine("Horse despawn");
                    }

                    await Delay(500);

                    timeout += 1;

                    if (API.DoesEntityExist(horsePed) && timeout == 9)
                    {
                        Debug.WriteLine("Horse can't despawn");
                    }

                }
            }
            if (spawnedCart != null)
            {
                int carVehicle = spawnedCart.Item1;
                API.DeleteVehicle(ref carVehicle);
            }

        }

        private float getHorseDistance(int horsePed)
        {
            Vector3 playerCoords = API.GetEntityCoords(API.PlayerPedId(), true, true);
            Vector3 horseCoords = API.GetEntityCoords(horsePed, true, true);
            return API.GetDistanceBetweenCoords(playerCoords.X, playerCoords.Y, playerCoords.Z, horseCoords.X, horseCoords.Y, horseCoords.Z, false);
        }

        private void GetMyStables(List<dynamic> stableDB)
        {
            MyHorses.Clear();
            MyCarts.Clear();

            foreach (dynamic horses in stableDB)
            {
                if (horses.type == "horse")
                {
                    Debug.WriteLine(horses.name);

                    bool isdefault = Convert.ToBoolean(horses.isDefault);

                    Horse _h = new Horse(horses.id, horses.name, horses.modelname, horses.xp, horses.status, horses.gear, isdefault, false);

                    MyHorses.Add(_h);

                    if (isdefault)
                    {
                        spawnedHorse = new Tuple<int, Horse>(-1, _h);
                    }

                }
                else
                {
                    Debug.WriteLine(horses.name);

                    bool isdefault = Convert.ToBoolean(horses.isDefault);

                    Cart _h = new Cart(horses.id, horses.name, horses.modelname, horses.xp, horses.status, horses.gear, isdefault, false);

                    MyCarts.Add(_h);

                    if (isdefault)
                    {
                        spawnedCart = new Tuple<int, Cart>(-1, _h);
                    }
                }
            }

            isLoading = false;
        }

        public async Task DrawTxt(string text, float x, float y, float fontscale, float fontsize, int r, int g, int b, int alpha, bool textcentred, bool shadow)
        {
            long str = Function.Call<long>(Hash._CREATE_VAR_STRING, 10, "LITERAL_STRING", text);
            Function.Call(Hash.SET_TEXT_SCALE, fontscale, fontsize);
            Function.Call(Hash._SET_TEXT_COLOR, r, g, b, alpha);
            Function.Call(Hash.SET_TEXT_CENTRE, textcentred);
            if (shadow) { Function.Call(Hash.SET_TEXT_DROPSHADOW, 1, 0, 0, 255); }
            Function.Call(Hash.SET_TEXT_FONT_FOR_CURRENT_COMMAND, 1);
            Function.Call(Hash._DISPLAY_TEXT, str, x, y);
        }
    }
}
