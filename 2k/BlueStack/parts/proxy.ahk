runPostern() {
    ClickToEny(["prx_postern"], { sleepAfter: 1000 })
    ClickToEny(["Android_homeBtn"])
    return WaithForEny(["proxy_active", "proxy_active2"])
}