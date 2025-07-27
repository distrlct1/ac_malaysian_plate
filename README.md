> ⚠️ **Disclaimer:** This is a fan-made mod and **not affiliated with JPJ or any Malaysian government agency**.  
> No real vehicle data is used. Plates are generated purely based on known formatting styles for immersion and realism in Assetto Corsa.  
> This mod is for **entertainment purposes only**. Do not use for impersonation or illegal activities.

---

# 🇲🇾 Malaysian License Plate Generator for Assetto Corsa (UK/EU Styles)

A modular, customizable license plate generator made for Assetto Corsa using CSP Paintshop.  
Supports a wide variety of plate types including Malaysian EV plates, UK-styled two-liners, and EU-style one-liners.

> Built to be extensible, dev-friendly, and easily adaptable for future formats or regional styles.

---

## 📂 Features

- 🔧 **Modular + Extensible**
  Each plate is its own module with shared utilities. Add new formats easily with minimal code duplication.
  
- 🧠 **Shared Drawing Logic**  
  Common utilities live in `_shared.lua` to reduce redundancy and keep code clean.

- 🧪 **Dynamic Input Fields**  
  Real-time preview and input customization via CSP Paintshop UI.

- 📚 **Authentic Plate Logic (State + Region Aware)**  
  Prefixes, postfixes, and extra letters are based on real-world Malaysian formats:
  - Peninsular (A–T), KL (V, W), Langkawi (KV), Putrajaya (F), Sarawak (Q), Sabah (S)
  - Special plates like “PATRIOT”, “WWW”, “PERODUA” handled separately
  - Smart postfix logic per region (e.g. Sabah skips 'Z', 'Q')

## 🆕 Included Plate Types

| Format ID        | Description                     | Style                  |
|------------------|----------------------------------|------------------------|
| `EV`             | Malaysian EV plate (FE-FONT)     | Green background       |
| `UK_Simple`      | UK-style plate (two-liner)       | No frame               |
| `UK_Framed`      | UK-style plate (two-liner)       | Silver frame           |
| `EU_Simple`      | EU-style plate (single-line)     | Centered, no frame     |
| `EU_Framed`      | EU-style plate (single-line)     | Centered, silver frame |

## 🧰 File Structure
```
📁 Malaysia/
  📁 PlateTypes/
  ├── EV.lua
  ├── EU_Simple.lua
  ├── EU_Framed.lua
  ├── UK_Simple.lua
  ├── UK_Framed.lua
  ├── _shared.lua
  ├── EV_bg.png, EV_nm.png, etc.
📄 style.lua # Entry point that loads all plates
📄 FE-FONT.TTF # Used for EV plate text
📄 arialbd.ttf # Used by UK/EU plates
📄 calistomtitalic.ttf
```

## 🔧 How to Install

Drop the extracted folder into:

```
%localappdata%\AcTools Content Manager\Data (User)\License Plates
```

## 🎮 How to Use
1. Launch Custom Showroom
2. Go to Paintshop → License Plate
3. Select the `Malaysia` from `Style` dropdown
4. PlateDesign - e.g. EU, UK, EV, Simple, or Framed
5. plateType - Determines how the plate is generated.
    - Standard - Generate realistic Malaysia state plate
    - Special - Generate special issued JPJ plate
    - Custom - Generate plate based on user input
6. Prefix - For custom input
7. Number - Sliders to generate plate and for custom input
8. Postfix - For custom input

---

## 🖊️ Adding New Plate Designs

1. Create a new `YourPlateName.lua` inside `PlateTypes/`
2. Define a `draw_plate()` function following existing examples
3. Add background and normal map images (e.g., `YourPlateName_bg.png`)
4. Register it in `style.lua` by loading your module

---

## 🧾 License
**MIT License** – Free to use, reuse, remix, repost, and build on.
> Credit not required, but appreciated.  
> Just don’t try to lock it behind a paywall or pull any NFT clownery 🪦

## 🏁 Credits

Made by distrlct1. Discord: respwn3d
