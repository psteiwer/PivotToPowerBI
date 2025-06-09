Class PivotToPowerBI.CustomKPIAction Extends %DeepSee.KPI
{

XData KPI [ XMLNamespace = "http://www.intersystems.com/deepsee/kpi" ]
{
<kpi
xmlns="http://www.intersystems.com/deepsee/kpi"
 name="PivotToPowerBI Custom Action">

<action name="PivotToPowerBI"/>
<!--action name="PivotToPowerBIService"/-->
</kpi>
}

ClassMethod %OnDashboardAction(pAction As %String, pContext As %ZEN.proxyObject) As %Status
{
	if (pAction="PivotToPowerBI") {
        // Convert selected context to a new table
		Set tCurrFilterSpec = $P(pContext.currFilterSpec," ",2,*)
        If tCurrFilterSpec="" {
            // Check filters to see if no context is selected but filters are applied
            Set tRS=##class(%DeepSee.ResultSet).%New()
            Do tRS.%PrepareMDX(pContext.mdx)
            Do tRS.%GetFiltersForCellRange(.tFilters,0,0,,,,1,1)
            set f=$O(tFilters(""))
            While f'="" {
                Set tCurrFilterSpec=tCurrFilterSpec_"%FILTER "_tFilters(f)
                set f=$O(tFilters(f))
            }
		    Set tCurrFilterSpec = $P(tCurrFilterSpec," ",2,*)
        }
		Set tNewTableName = "PivotToPowerBI."_pContext.cubeName
        Do $system.OBJ.Delete(tNewTableName,"e /displayerror=0 /displaylog=0")
		Set tSC = ##class(%DeepSee.ResultSet).%CreateTable(pContext.cubeName,tNewTableName,tCurrFilterSpec)
	}
    
	If (pAction="PivotToPowerBI") { 
        // TODO: Implement server version here
        // This should use PowerBI APIs to create a new connection to the generated table
    }

	quit $$$OK
}

ClassMethod UpdateActionClass(pCube = "HOLEFOODS")
{
    // Update actionClass for HoleFoods cube
    Set tSC=$$$OK
    Set tActionClass="PivotToPowerBI.CustomKPIAction"

    Set tCubeClass=##class(%DeepSee.Utils).%GetCubeClass(pCube)

    Set tModel=##class(%DeepSee.Utils).%GetModel(pCube)
    Set tModel.actionClass=tActionClass

    Set tSC=##class(%DeepSee.Utils).%SaveCubeDefinition(tCubeClass,,tModel.description,tModel)
    Quit:$$$ISERR(tSC) tSC
    Set tSC=$System.OBJ.Compile(tCubeClass,"fck /displayerror=0 /displaylog=0")
    Quit:$$$ISERR(tSC) tSC

    Quit tSC
}

}
