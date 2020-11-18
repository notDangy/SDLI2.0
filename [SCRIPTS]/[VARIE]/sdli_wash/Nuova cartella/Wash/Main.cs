using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Threading;
using System.Threading.Tasks;
using CitizenFX.Core;
using CitizenFX.Core.Native;

namespace Wash
{
    public class Main : BaseScript
    {
        protected Config Config { get; set; }
        protected bool initialized = false;
        protected string EnableRagdoll = "false";
        protected string RagdollKey = "0x4AF4D473";
        protected int CleaningTime = 20000;
        protected string progressBarsText = "Lavando";
        protected string NearbyText = "Premi ENTER per farti una doccia.";
        protected string ProgressBarEnabled = "true";

        //Vector3 bathPos = new Vector3(-317.38f, 762.64f, 117.44f);
        

        List<Vector3> pos = new List<Vector3>();
        



        public Main()
        {
            Tick += OnTick;

            //List<Vector3> pos = new List<Vector3>();
            pos.Add(new Vector3(-317.38f, 762.64f, 117.44f));
            pos.Add(new Vector3(-1812.5f, -374.1f, 166.5f));
            pos.Add(new Vector3(-823.8f, -1318.1f, 43.7f));
            pos.Add(new Vector3(2628.6f, -1223.4f, 59.6f));
            pos.Add(new Vector3(2951.9f, 1335.1f, 44.5f));
            pos.Add(new Vector3(1336.7f, -1378.8f, 84.3f));
            pos.Add(new Vector3(633.1f, 2203.5f, 221.3f));



            /*
            API.RegisterCommand("ecancel", new Action<int, List<object>, string>((source, args, raw) =>
            {
                Function.Call(Hash.CLEAR_PED_TASKS_IMMEDIATELY, API.PlayerPedId());
            }), false);

            API.RegisterCommand("bathdistance", new Action<int, List<object>, string>((source, args, raw) =>
            {
                GetDistance();
            }), false);


            API.RegisterCommand("ragdollkey", new Action<int, List<object>, string>((source, args, raw) =>
            {
                CitizenFX.Core.Debug.WriteLine($"RagdollKey is { Convert.ToUInt32(RagdollKey, 16) }");
            }), false);*/

        }


        [Tick]
        private async Task OnTick()
        {
            if (!initialized)
            {
                initialized = true;

                LoadConfig();

            }

            if (!API.IsEntityDead(API.PlayerPedId()))
            {
                foreach (Vector3 i in pos)
                {
                    if (GetDistance(i) <= 2)
                    {
                        //CitizenFX.Core.Debug.WriteLine("Distance <= 2");
                        Console.WriteLine(NearbyText.ToString());
                        DrawText("Premi ENTER per farti una doccia.", 0.5f, 0.95f);

                        if (API.IsControlJustPressed(0, 0xC7B5340A))
                        {
                            Function.Call(Hash.TASK_START_SCENARIO_AT_POSITION, API.PlayerPedId(), API.GetHashKey("WORLD_HUMAN_WASH_FACE_BUCKET_GROUND_NO_BUCKET"), i.X, i.Y, i.Z, 184.04f, CleaningTime, true, false, 0, true);
                            if (ProgressBarEnabled == "true")
                            {
                                Exports["progressBars"].startUI(CleaningTime, "Pulendo");
                            }
                            await Delay(CleaningTime);
                            Wash();
                        }
                    }
                }
                if (EnableRagdoll == "true")
                {
                    if (API.IsControlJustPressed(0, Convert.ToUInt32(RagdollKey, 16)))
                    {
                        API.SetPedToRagdoll(API.PlayerPedId(), 1000, 1000, 0, true, true, true);
                    }
                }
            }
        }

        public void Wash()
        {
            API.ClearPedEnvDirt(API.PlayerPedId());
            API.ClearPedBloodDamage(API.PlayerPedId());
            API.ClearPedWetness(API.PlayerPedId());
            API.ClearPedDamageDecalByZone(API.PlayerPedId(), 10, "ALL");
            CitizenFX.Core.Debug.WriteLine("Player has been cleaned");
        }

        public float GetDistance(Vector3 bath)
        {
            Vector3 playerPos = API.GetEntityCoords(API.PlayerPedId(), true, true);
            return API.Vdist(playerPos.X, playerPos.Y, playerPos.Z, bath.X, bath.Y, bath.Z);
        }

        public void DrawText(string text, float x, float y)
        {
            API.SetTextScale(0.5f, 0.5f);
            API.SetTextColor(255, 255, 255, 255);
            API.SetTextCentre(true);
            API.SetTextDropshadow(1, 0, 0, 0, 200);
            API.SetTextFontForCurrentCommand(0);
            Function.Call((Hash)0xADA9255D, 10); // Font
            API.DisplayText(Function.Call<long>(Hash._CREATE_VAR_STRING, 10, "LITERAL_STRING", text), x, y);
        }
        protected void LoadConfig()
        {
            string configContent = null;

            try
            {
                configContent = API.LoadResourceFile(API.GetCurrentResourceName(), "config.ini");
            }
            catch (Exception e)
            {
                Debug.WriteLine($"An error occurred while loading the config file, error description: {e.Message}.");
            }

            Config = new Config(configContent);

            EnableRagdoll = Config.Get("EnableRagdoll", "false");
            ProgressBarEnabled = Config.Get("ProgressBarEnabled", "true");
            progressBarsText = Config.Get("progressBarsText", "Pulendoti");
            NearbyText = Config.Get("NearbyText", "Premi ENTER per farti una doccia");
            RagdollKey = Config.Get("RagdollKey", "0x4AF4D473");

            var CleaningTimeString = Config.Get("CleaningTime", "20000");
            if (int.TryParse(CleaningTimeString, out int tmpCleaningTime))
            {
                CleaningTime = tmpCleaningTime;
            }

            /*Debug.WriteLine($"EnableRagdoll: {Config.Get("EnableRagdoll", "true")}");
            Debug.WriteLine($"RagdollKey: {Config.Get("RagdollKey", "0x4AF4D473")}");
            Debug.WriteLine($"CleaningTime: {Config.Get("CleaningTime", "20000")}");
            Debug.WriteLine($"progressBarsText: {Config.Get("progressBarsText", "Cleaning")}");
            Debug.WriteLine($"NearbyText: {Config.Get("NearbyText", "Press ENTER to clean yourself")}");*/
        }
    }
}
