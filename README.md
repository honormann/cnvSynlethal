# cnvSynlethal
***
<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
   <li><a href="#installation">Installation</a></li>
   <li><a href="#usage">Usage</a></li>
  </ol>
</details>

### Installation
   1. Install package
   ```sh
   devtools::install_github('honormann/cnvColethal')
   ```
   2. Based on your use, you may need to download one or more of the following
   
   
   ---->[Data files](https://drive.google.com/file/d/1R1eEtTRVKxGMpAo9NX--Txe_3PtOPJtX/view?usp=sharing)
    (no necessary for the package use).
    
### Usage
***
   1. Load Raw Data
   ```sh
   library("cnvColethal)
   rawData = new("rawData")   
   rawData = LoadData(rawData)
   ```
   2. Load GeneA Data
   ```sh
   GeneA = new("GeneA")
   GeneA = LoadDataA(obj = GeneA, raw_obj = rawData)
   ```
   3. Load GeneB Data
   ```sh
   GeneB = new("GeneB")
   objB = LoadDataB(obj = objB, raw_obj = rawData, objA = GeneA)
   ```
