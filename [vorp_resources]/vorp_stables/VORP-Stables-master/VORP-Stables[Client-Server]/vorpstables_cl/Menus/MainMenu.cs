using CitizenFX.Core;
using MenuAPI;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace vorpstables_cl.Menus
{
    class MainMenu
    {
        private static Menu mainMenu = new Menu(GetConfig.Langs["TitleMenuStables"], GetConfig.Langs["SubTitleMenuStables"]);
        private static bool setupDone = false;
        private static void SetupMenu()
        {
            if (setupDone) return;
            setupDone = true;
            MenuController.AddMenu(mainMenu);

            MenuController.EnableMenuToggleKeyOnController = false;
            MenuController.MenuToggleKey = (Control)0;

            // Buy Horses Menu
            MenuController.AddSubmenu(mainMenu, BuyHorsesMenu.GetMenu());

            MenuItem subMenuBuyHorses = new MenuItem(GetConfig.Langs["TitleMenuBuyHorses"], GetConfig.Langs["SubTitleMenuBuyHorses"])
            {
                RightIcon = MenuItem.Icon.ARROW_RIGHT
            };

            mainMenu.AddMenuItem(subMenuBuyHorses);
            MenuController.BindMenuItem(mainMenu, BuyHorsesMenu.GetMenu(), subMenuBuyHorses);

            // My Horses Menu
            MenuController.AddSubmenu(mainMenu, MyHorsesMenu.GetMenu());

            MenuItem subMenuMyHorses = new MenuItem(GetConfig.Langs["TitleMenuHorses"], GetConfig.Langs["SubTitleMenuHorses"])
            {
                RightIcon = MenuItem.Icon.ARROW_RIGHT
            };

            mainMenu.AddMenuItem(subMenuMyHorses);
            MenuController.BindMenuItem(mainMenu, MyHorsesMenu.GetMenu(), subMenuMyHorses);

            // Buy Carriages Menu
            MenuController.AddSubmenu(mainMenu, BuyCarriagesMenu.GetMenu());

            MenuItem subMenuBuyCarriages = new MenuItem(GetConfig.Langs["TitleMenuBuyCarts"], GetConfig.Langs["SubTitleMenuBuyCarts"])
            {
                RightIcon = MenuItem.Icon.ARROW_RIGHT
            };

            mainMenu.AddMenuItem(subMenuBuyCarriages);
            MenuController.BindMenuItem(mainMenu, BuyCarriagesMenu.GetMenu(), subMenuBuyCarriages);

            // My Carriages Menu
            MenuController.AddSubmenu(mainMenu, MyCarriagesMenu.GetMenu());

            MenuItem subMenuMyCarriages = new MenuItem(GetConfig.Langs["TitleMenuCarts"], GetConfig.Langs["SubTitleMenuCarts"])
            {
                RightIcon = MenuItem.Icon.ARROW_RIGHT
            };

            mainMenu.AddMenuItem(subMenuMyCarriages);
            MenuController.BindMenuItem(mainMenu, MyCarriagesMenu.GetMenu(), subMenuMyCarriages);

            //Nico Nico Ni nanananoe

            mainMenu.OnMenuOpen += (_menu) => {

            };

            mainMenu.OnMenuClose += (_menu) =>
            {
              
            };

        }



        public static Menu GetMenu()
        {
            SetupMenu();
            return mainMenu;
        }

    }
}
