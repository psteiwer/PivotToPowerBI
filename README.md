# PivotToPowerBI

## Using this demo
### Steps to perform demo
1) Clone Repo/Download files
2) Navigate to directory
3) docker compose up -d --build
4) Navigate to: http://localhost:61773/csp/user/_DeepSee.UI.Analyzer.zen?$NAMESPACE=USER&CUBE=HoleFoods.cube
5) Place some dimension on rows, DateOfSale for example
6) Select a cell that you would like to further analyze the data behind
7) Select PivotToPowerBI custom action
8) Open ./Samples/HoleFoodsSample.pbit


### Demo in action
Steps 1-3

![Setup Screenshot](https://github.com/psteiwer/PivotToPowerBI/blob/main/Assets/Demo1.png)

Steps 5-7 (DateOfSale dragged to rows, cell for 2022 clicked, PivotToJupyer custom action selected

![Analyzer Screenshot](https://github.com/psteiwer/PivotToPowerBI/blob/main/Assets/Demo2.png)

Step 8

![PowerBI Screenshot](https://github.com/psteiwer/PivotToPowerBI/blob/main/Assets/Demo3.png)

## Install with ZPM
```zpm "install pivottopowerbi"```

Installing with ZPM simply installs the CustomKPIAction class (PivotToPowerBI.CustomKPIAction.cls), you will then need to add reference to this custom action in your cube. To implement custom actions easier, see https://github.com/psteiwer/CustomCubeActionManager

## Implementation Guide

### Custom Action
Custom Actions come from code that is implemented in a "KPI Action Class". This class is then pointed to by a cube so it can use the defined custom actions. In this example, the class ```PivotToPowerBI.CustomKPIAction``` was created to implement the custom action. Inside of ```%OnDashboardAction```, there is logic to pull the current query context out of the pContext object so either the selected cell on the pivot table, or the context of the entire pivot table will be used. Once this context is extracted, a new table is created based on the Listing results of the current query context. This table is created as ```PivotToPowerBI.<cubename>```, which can then be queried from Power BI.

## Power BI Desktop
Currently, this code works with Power BI Desktop. It could be enhanced to use the Power BI APIs and interact with Power BI Server.
