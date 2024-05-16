runPostern() {
    ClickToEny(["prx_postern"], { sleepAfter: 1000 })
    ClickToEny(["Android_homeBtn"])
    return WaithForEny(["prx_active1", "prx_active2"])
}