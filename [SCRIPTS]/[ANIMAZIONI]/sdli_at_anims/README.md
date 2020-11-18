# AT_ANIMS MENU!

## 1. Requirements

- [VORP-Core](https://github.com/VORPCORE/VORP-Core)

## 2. Installation

- Add ```ensure at_anims``` in your server.cfg
- You can change the script language in ```Config.json```
- If you want to add new animations, you need to put this 🔽 in AnimationsList:
Example animation [image](https://cdn.discordapp.com/attachments/731548283868282921/745282178325151744/Screenshot_320.png)
```json
    {
      "Name": "Animation Name", // Name that will appear in the Menu
      "Dic": "", // Look Example
      "Anim": "", // Look Example
      "Type": "animation" // If it is an animation
    }
```
- If you want to add new sceneries, you need to put this:
```json
    {
      "Name": "Animation Name", // Name that will appear in the Menu
      "Anim": "", // Example: WORLD_HUMAN_SMOKE_INTERACTION
      "Type": "scenario" // If it is an scenery
    }
```

- If you want to add new emote, you need to put this 🔽 in EmotesList:
```json
    {
      "Name": "Emote Name",
      "Emote": -339257980 // Emote hash
    }
```
## 3. Support
- To get support --> [Discord](http://discord.vorpcore.com/)

## 4. Credits
- Thanks for the help [VORP Core Team](https://github.com/vorpcore)
- Thanks for test [Neo Green](https://github.com/NeoGaming22), [Mikelo](https://github.com/djmikelo) and [Gandalfor](https://github.com/Gandalfor)