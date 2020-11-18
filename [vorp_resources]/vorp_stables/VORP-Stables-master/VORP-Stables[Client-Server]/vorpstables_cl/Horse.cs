using CitizenFX.Core;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace vorpstables_cl
{
    public class Horse
    {
        private int ID;
        private string Name;
        private string HorseModel;

        private int XP;

        private JObject Status;

        private JObject Gear;

        private bool isDead;

        private bool isDefault;


        /*Timer*/
        private int deadTimeRest;

        public Horse(int id, string name, string horseModel, int xP, string status, string jsonGear, bool isdefault, bool isdead)
        {
            this.ID = id;
            Name = name;
            HorseModel = horseModel;
            XP = xP;

            if (String.IsNullOrEmpty(status))
            {
                Status = new JObject();
            }
            else
            {
                Status = JObject.Parse(status);
            }

            if (String.IsNullOrEmpty(jsonGear))
            {
                JObject def = new JObject();
                def.Add("saddle", -1);
                def.Add("blanket", -1);
                def.Add("mane", -1);
                def.Add("tail", -1);
                def.Add("bag", -1);
                def.Add("bedroll", -1);
                def.Add("stirrups", -1);
                def.Add("horn", -1);
                def.Add("lantern", -1);
                def.Add("mask", -1);

                Gear = def;
            }
            else
            {
                Gear = JObject.Parse(jsonGear);

                //New Update (mask, lantern)
                if (!Gear.ContainsKey("lantern") || !Gear.ContainsKey("mask")) 
                {
                    Gear.Add("lantern", -1);
                    Gear.Add("mask", -1);
                }


            }

            isDefault = isdefault;
            isDead = isdead;
        }

        public Horse()
        { 
            
        }

        public JObject status { get => Status; set => Status = value; }

        public int getHorseDeadTime()
        {
            
            return deadTimeRest;
        }

        public void setHorseDead(int time)
        {
            deadTimeRest = time;
        }

        public int getHorseId()
        {
            return ID;
        }

        public string getHorseModel()
        {
            return HorseModel;
        }
        public string getHorseName()
        {
            return Name;
        }
        public JObject getGear()
        {
            return Gear;
        }

        public bool IsDefault()
        {
            return this.isDefault;
        }
        public void setDefault(bool def)
        {
            if (!def)
            {
                this.isDefault = false;
            }
            else
            {
                for (int i = 0; i < HorseManagment.MyHorses.Count; i++)
                {
                    if (HorseManagment.MyHorses[i].ID != this.ID)
                    {
                        HorseManagment.MyHorses[i].setDefault(false);
                    }

                }
                this.isDefault = true;
                HorseManagment.spawnedHorse = new Tuple<int, Horse>(0, this);
                HorseManagment.SetDefaultHorseDB(this.ID);
            }

        }

    }
}
