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
    public class Cart
    {
        private int ID;
        private string Name;
        private string CartModel;

        private int XP;

        private JObject Status;

        private JObject Gear;

        private bool isDead;

        private bool isDefault;


        /*Timer*/
        private int deadTimeRest;

        public Cart(int id, string name, string cartModel, int xP, string status, string jsonGear, bool isdefault, bool isdead)
        {
            this.ID = id;
            Name = name;
            CartModel = cartModel;
            XP = xP;
            Status = new JObject();
            Gear = new JObject();
            isDefault = isdefault;
            isDead = isdead;
        }

        public Cart()
        { 
            
        }

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
            return CartModel;
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
                for (int i = 0; i < HorseManagment.MyCarts.Count; i++)
                {
                    if (HorseManagment.MyCarts[i].ID != this.ID)
                    {
                        HorseManagment.MyCarts[i].setDefault(false);
                    }

                }
                this.isDefault = true;
                HorseManagment.spawnedCart = new Tuple<int, Cart>(0, this);
                HorseManagment.SetDefaultCartDB(this.ID);
            }

        }

    }
}
