ClickAsist() {
    ; Run and Setup Click Assistant
    ClickToEny(["clickAsist"], { sleepAfter: 500 })
;    ClickToEny(["clickAsist_rating-not"], 3)
    ClickToEny(["clickAsist_close"])
    ClickToEny(["clickAsist_StartService"])
    ClickToEny(["clickAsist_cancelAD"])
    ClickToEny(["clickAsist_saved-configs"])
    ClickToEny(["clickAsist_run-config-2"], { clickPosition: [0.95, 0.5]})
    ClickToEny(["clickAsist_hide-targets"])
    ClickToEny(["Android_homeBtn"])
}