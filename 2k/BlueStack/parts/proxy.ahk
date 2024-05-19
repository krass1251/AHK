runPostern() {
    ClickToEny(["prx_postern"], { sleepAfter: 1000 })
    ClickToEny(["Android_homeBtn"])
    return WaithForEny(["proxy_active1", "proxy_active2"])
}