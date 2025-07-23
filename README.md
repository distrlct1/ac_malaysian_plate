# 🇲🇾 Malaysian License Plate Generator for Assetto Corsa (UK/EU Styles)

Custom CSP Paintshop license plate mod for Assetto Corsa, fully coded in Lua. Includes **UK-style** (double-line) and **EU-style** (long plate) versions. Auto-generates realistic Malaysian number plates with **state-specific formats**, **special series**, and full **custom mode**.

---

## 🧭 Versions Available

### 🏴 UK-Style Plate (Double-Line)
- Two lines:
  - Line 1: Prefix
  - Line 2: Number + Postfix
- Good for cars with UK-style plate placement
- Ideal for compact presentation or vintage styles

### 🇪🇺 EU-Style Plate (Long Plate)
- Single line: `Prefix + Body + Number + Postfix`
- Fits modern Euro car plates
- Clean wide display for detailed plates

🧱 Both versions have identical logic and state handling, just visual layout difference.

---

## 🧠 Features

✅ Real Malaysian state codes (Peninsular, Sabah, Sarawak, KL, etc.)  
✅ Subdivision letters (e.g. `QA`, `SB`, `ST`) for East Malaysia  
✅ Special/vanity series like `PROTON`, `G1M`, `VIP`, `UiTM`, etc.  
✅ Custom mode for full control of prefix/number/postfix  
✅ Built-in font override support  
✅ Full Lua-based random plate logic  
✅ Paintshop compatible, ready to use

---

## 🛠 Installation

Drop the extracted folder (choose UK or EU version) into:

```
%localappdata%\AcTools Content Manager\Data (User)\License Plates
```

Each version comes as its own folder (e.g. Malaysia - Plates UK and Malaysia - Plates EU).

🎮 How to Use
1. Launch Custom Showroom
2. Go to Paintshop → License Plate
3. Select the Malaysian plate from the dropdown
4. Use:
    - Standard – Generates realistic state plates
    - Special – Pulls from a big list of known custom prefixes
    - Custom – Full manual input
⚠️ Some cars don’t render license plates properly. Try different cars if nothing shows up.

✍️ Change Font / Style
Open style.lua inside the mod folder. Find:
```
text.font = 'arialbold.ttf'
```
Swap 'arialbold.ttf' with any .ttf file you place in the same folder.

🧬 Plate Generator Logic
The script supports 3 modes:
    - Standard: Randomly generates legal Malaysian plates by region/state/subdivision
    - Special: Generates plates with special series (e.g. PROTON 89, VIP 88 M)
    - Custom: Manual inputs for prefix, number, and optional postfix
Example Outputs:
    - WQH 1234 A (KL Old Series)
    - SAK 5678 (Sabah)
    - UNIMAS 89 (University)
    - KV 9876 B (Langkawi)
    - G1M 1 M (Special Plate)
🧠 Every region has its own rules — handled in code.
🛠️ View source logic in style.lua for full breakdown.

📦 Contents
Each version folder includes:
  - malaysia_bg.png – Background texture
  - malaysia_nm.png – Normal map for lighting
  - style.lua – The generator code (you just posted 🔥)
  - Optional fonts (arialbold.ttf, calistomtitalic.ttf, etc.)

🧾 License
**MIT License** – Free to use, reuse, remix, repost, and build on.
> Credit not required, but appreciated.  
> Just don’t try to lock it behind a paywall or pull any NFT clownery 🪦

🏁 Credits
Made by distrlct1.
Old project, just dropping it out there now.
Use it, mod it, break it — I ain’t maintaining it but y’all go crazy 🤙

💾 Download
Upload your .zip files (one for each version) under GitHub Releases:
Malaysia - Plates UK.zip
Malaysia - Plates EU.zip
