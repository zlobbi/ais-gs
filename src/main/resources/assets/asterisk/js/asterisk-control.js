function minimize(){
    console.log("minimize");
    $('.window').addClass('minimized');
}

function maximize(){
    console.log("maximize");
    $(".window").removeClass('minimized');
}

function markPresent() {
    window.markDate = new Date();
    $(document).ready(function() {
        $("div.absent").toggleClass("present");
    });
    updateClock();
}

function updateClock() {
    var currDate = new Date();
    var diff = currDate - markDate;
    document.getElementById("timer").innerHTML = format(diff/1000);
    setTimeout(function() {updateClock()}, 1000);
}

function format(seconds) {
    var numhours = parseInt(Math.floor(((seconds % 31536000) % 86400) / 3600),10);
    var numminutes = parseInt(Math.floor((((seconds % 31536000) % 86400) % 3600) / 60),10);
    var numseconds = parseInt((((seconds % 31536000) % 86400) % 3600) % 60,10);
    return ((numhours<10) ? "0" + numhours : numhours)
        + ":" + ((numminutes<10) ? "0" + numminutes : numminutes)
        + ":" + ((numseconds<10) ? "0" + numseconds : numseconds);
}

//sip credentials
var t = sipId;

if(t !== ''){
    console.log("ASTERISK OPERATION STARTED");
    var sipIdCurrent = t.replace(/\s/g,'');

    var disable_callbtn_options = true;
    var txtDisplayName = sipIdCurrent;
    var txtPrivateIdentity = sipIdCurrent;
    var txtPublicIdentity = "sip:"+sipIdCurrent+"@"+asteriskIdentityUrl;//"sip:"+sipIdCurrent+"@10.111.69.157:5160";
    var txtPassword = sipIdCurrent;
    var txtRealm = asteriskRealm;//"pbx.it.gov.kg:5160";
    var websocket_server_url = asteriskWsUrl;//"wss://pbx.it.gov.kg:8089/ws";
    var disableDebug = "false";
    var sip_outboundproxy_url = "";
    var ice_servers = [];
    var expert_bandwidth = "";
    var video_size = "";
    /////////////////////
    var sTransferNumber;
    var oRingTone, oRingbackTone;
    var oSipStack, oSipSessionRegister, oSipSessionCall, oSipSessionTransferCall;
    var videoRemote, videoLocal, audioRemote;
    var bFullScreen = false;
    var oNotifICall;
    var bDisableVideo = false;
    var viewVideoLocal, viewVideoRemote, viewLocalScreencast;

    audioRemote = document.getElementById("audio_remote");
    var oConfigCall = {
        audio_remote: audioRemote,
        screencast_window_id: 0x00000000, // entire desktop
        events_listener: { events: '*', listener: onSipEventSession },
        bandwidth: { audio: undefined, video: undefined },
        video_size: { minWidth: undefined, minHeight: undefined, maxWidth: undefined, maxHeight: undefined },
        sip_caps: [
            { name: '+g.oma.sip-im' },
            { name: 'language', value: '\"en,fr\"' }
        ]
    };
    var oReadyStateTimer;

    C = {divKeyPadWidth: 220};

    window.onload = function () {

        window.console && window.console.info && window.console.info("location=" + window.location);

        audioRemote = document.getElementById("audio_remote");

        document.onkeyup = onKeyUp;
        document.body.onkeyup = onKeyUp;
        //divCallCtrl.onmousemove = onDivCallCtrlMouseMove;

        loadCredentials();

        // Initialize Call button
        uiBtnCallSetText("Call");

        var getPVal = function (PName) {
            var query = window.location.search.substring(1);
            var vars = query.split('&');
            for (var i = 0; i < vars.length; i++) {
                var pair = vars[i].split('=');
                if (decodeURIComponent(pair[0]) === PName) {
                    return decodeURIComponent(pair[1]);
                }
            }
            return null;
        }

        var preInit = function () {
            // set default webrtc type (before initialization)
            var s_webrtc_type = getPVal("wt");
            var s_fps = getPVal("fps");
            var s_mvs = getPVal("mvs"); // maxVideoSize
            var s_mbwu = getPVal("mbwu"); // maxBandwidthUp (kbps)
            var s_mbwd = getPVal("mbwd"); // maxBandwidthUp (kbps)
            var s_za = getPVal("za"); // ZeroArtifacts
            var s_ndb = getPVal("ndb"); // NativeDebug

            if (s_webrtc_type) SIPml.setWebRtcType(s_webrtc_type);

            // initialize SIPML5
            SIPml.init(postInit);

            // set other options after initialization
            if (s_fps) SIPml.setFps(parseFloat(s_fps));
            if (s_mvs) SIPml.setMaxVideoSize(s_mvs);
            if (s_mbwu) SIPml.setMaxBandwidthUp(parseFloat(s_mbwu));
            if (s_mbwd) SIPml.setMaxBandwidthDown(parseFloat(s_mbwd));
            if (s_za) SIPml.setZeroArtifacts(s_za === "true");
            if (s_ndb == "true") SIPml.startNativeDebug();

        };

        oReadyStateTimer = setInterval(function () {
                if (document.readyState === "complete") {
                    clearInterval(oReadyStateTimer);
                    // initialize SIPML5
                    preInit();
                }
            },
            500);
        // Register New Sip
        sipRegister();

    };

    function postInit() {
        // check for WebRTC support
        if (!SIPml.isWebRtcSupported()) {
            // is it chrome?
            if (SIPml.getNavigatorFriendlyName() == 'chrome') {
                if (confirm("You're using an old Chrome version or WebRTC is not enabled.\nDo you want to see how to enable WebRTC?")) {
                    window.location = 'http://www.webrtc.org/running-the-demos';
                }
                else {
                    window.location = "index.html";
                }
                return;
            }
            else {
                if (confirm("webrtc-everywhere extension is not installed. Do you want to install it?\nIMPORTANT: You must restart your browser after the installation.")) {
                    window.location = 'https://github.com/sarandogou/webrtc-everywhere';
                }
                else {
                    // Must do nothing: give the user the chance to accept the extension
                    // window.location = "index.html";
                }
            }
        }

        // checks for WebSocket support
        if (!SIPml.isWebSocketSupported()) {
            if (confirm('Your browser don\'t support WebSockets.\nDo you want to download a WebSocket-capable browser?')) {
                window.location = 'https://www.google.com/intl/en/chrome/browser/';
            }
            else {
                window.location = "index.html";
            }
            return;
        }

        // FIXME: displays must be per session
        viewVideoLocal = videoLocal;
        viewVideoRemote = videoRemote;

        if (!SIPml.isWebRtcSupported()) {
            if (confirm('Your browser don\'t support WebRTC.\naudio/video Call will be disabled.\nDo you want to download a WebRTC-capable browser?')) {
                window.location = 'https://www.google.com/intl/en/chrome/browser/';
            }
        }

        document.body.style.cursor = 'default';
        oConfigCall = {
            audio_remote: audioRemote,
            screencast_window_id: 0x00000000, // entire desktop
            events_listener: { events: '*', listener: onSipEventSession },
            bandwidth: { audio: undefined, video: undefined },
            video_size: { minWidth: undefined, minHeight: undefined, maxWidth: undefined, maxHeight: undefined },
            sip_caps: [
                { name: '+g.oma.sip-im' },
                { name: 'language', value: '\"en,fr\"' }
            ]
        };
    }

    function loadCredentials() {}

    function saveCredentials() {}

    // sends SIP REGISTER request to login
    function sipRegister() {
        // catch exception for IE (DOM not ready)
        try {

            // enable notifications if not already done
            if (window.webkitNotifications && window.webkitNotifications.checkPermission() != 0) {
                window.webkitNotifications.requestPermission();
            }

            // update debug level to be sure new values will be used if the user haven't updated the page
            SIPml.setDebugLevel(!(disableDebug == "true") ? "info" : "false");

            // create SIP stack
            oSipStack = new SIPml.Stack({
                realm: txtRealm,
                impi: txtPrivateIdentity,
                impu: txtPublicIdentity,
                password: txtPassword,
                display_name: txtDisplayName,
                websocket_proxy_url: websocket_server_url,
                outbound_proxy_url: sip_outboundproxy_url,
                ice_servers: [],
                enable_rtcweb_breaker: false,
                events_listener: { events: '*', listener: onSipEventStack },
                enable_early_ims: true,
                enable_media_stream_cache: false,
                bandwidth: expert_bandwidth,
                video_size:  video_size,
                sip_headers: [
                    { name: 'User-Agent', value: 'IM-client/OMA1.0 sipML5-v1.2016.03.04' },
                    { name: 'Organization', value: 'Doubango Telecom' }
                ]
            });

            if (oSipStack.start() != 0) {
                txtRegStatus.innerHTML = '<b>Failed to start the SIP stack</b>';
            }
            else return;
        }
        catch (e) {
            txtRegStatus.innerHTML = "<b>2:" + e + "</b>";
        }

    }

    // sends SIP REGISTER (expires=0) to logout
    function sipUnRegister() {
        if (oSipStack) {
            oSipStack.stop(); // shutdown all sessions
        }
    }

    // makes a Call (SIP INVITE)
    function sipCall(s_type) {
        var txtPhoneNumber = $("input[id='txtPhoneNumber']");
        console.log("Phone Number ",txtPhoneNumber.val());

        if (oSipStack && !oSipSessionCall && !tsk_string_is_null_or_empty(txtPhoneNumber.val())) {
            console.log("call on create");

            btnCall.disabled = true;
            btnHangUp.disabled = false;

            // create call session
            oConfigCall = {
                audio_remote: audioRemote,
                screencast_window_id: 0x00000000, // entire desktop
                events_listener: { events: '*', listener: onSipEventSession },
                bandwidth: { audio: undefined, video: undefined },
                video_size: { minWidth: undefined, minHeight: undefined, maxWidth: undefined, maxHeight: undefined },
                sip_caps: [
                    { name: '+g.oma.sip-im' },
                    { name: 'language', value: '\"en,fr\"' }
                ]
            };
            var lower = s_type.toLowerCase();
            oSipSessionCall = oSipStack.newSession(lower, oConfigCall);
            // make call
            if (oSipSessionCall.call(txtPhoneNumber.val()) != 0) {
                oSipSessionCall = null;
                txtCallStatus.value = 'Не удалось совершить звонок';
                btnCall.disabled = false;
                btnHangUp.disabled = true;
                return;
            }
            //saveCallOptions();
        }
        else if (oSipSessionCall) {
            txtCallStatus.innerHTML = '<i>Подключение...</i>';
            oSipSessionCall.accept(oConfigCall);
        }
        else{
            txtCallStatus.innerHTML = '<i>Ошибка</i>';
        }
    }

    // transfers the Call
    function sipTransfer() {
        if (oSipSessionCall) {
            var s_destination = prompt('Введите номер', '');
            if (!tsk_string_is_null_or_empty(s_destination)) {
                btnTransfer.disabled = true;
                if (oSipSessionCall.transfer(s_destination) != 0) {
                    txtCallStatus.innerHTML = '<i>Call transfer failed</i>';
                    btnTransfer.disabled = false;
                    return;
                }
                txtCallStatus.innerHTML = '<i>Transfering the Call...</i>';
            }
        }
    }

    // holds or resumes the Call
    function sipToggleHoldResume() {
        if (oSipSessionCall) {
            var i_ret;
            btnHoldResume.disabled = true;
            txtCallStatus.innerHTML = oSipSessionCall.bHeld ? '<i>Продолжение разговора...</i>' : '<i>Удержание...</i>';
            i_ret = oSipSessionCall.bHeld ? oSipSessionCall.resume() : oSipSessionCall.hold();
            if (i_ret != 0) {
                txtCallStatus.innerHTML = '<i>Удержание / Продолжение не удалось</i>';
                btnHoldResume.disabled = false;
                return;
            }
        }
    }

    // Mute or Unmute the Call
    function sipToggleMute() {
        if (oSipSessionCall) {
            var i_ret;
            var bMute = !oSipSessionCall.bMute;
            txtCallStatus.innerHTML = bMute ? '<i>Отключить звук</i>' : '<i>Включить звук</i>';
            i_ret = oSipSessionCall.mute('audio'/*could be 'video'*/, bMute);
            if (i_ret != 0) {
                txtCallStatus.innerHTML = '<i>Не удалось отключить / включить звук</i>';
                return;
            }
            oSipSessionCall.bMute = bMute;
            btnMute.value = bMute ? "Отключить звук" : "Включить звук";
        }
    }

    // terminates the Call (SIP BYE or CANCEL)
    function sipHangUp() {
        if (oSipSessionCall) {
            txtCallStatus.innerHTML = '<i>Отключение разговора...</i>';
            oSipSessionCall.hangup({ events_listener: { events: '*', listener: onSipEventSession } });
        }
    }

    function sipSendDTMF(c) {
        if (oSipSessionCall && c) {
            if (oSipSessionCall.dtmf(c) == 0) {
                try { dtmfTone.play(); } catch (e) { }
            }
        }
    }

    function startRingTone() {
        try { ringtone.play(); }
        catch (e) { }
    }

    function stopRingTone() {
        try { ringtone.pause(); }
        catch (e) { }
    }

    function startRingbackTone() {
        try { ringbacktone.play(); }
        catch (e) { }
    }

    function stopRingbackTone() {
        try { ringbacktone.pause(); }
        catch (e) { }
    }


    function openKeyPad() {
        divKeyPad.style.visibility = 'visible';
        divKeyPad.style.left = ((document.body.clientWidth - C.divKeyPadWidth) >> 1) + 'px';
        divKeyPad.style.top = '70px';
        divGlassPanel.style.visibility = 'visible';
    }

    function closeKeyPad() {
        divKeyPad.style.left = '0px';
        divKeyPad.style.top = '0px';
        divKeyPad.style.visibility = 'hidden';
        divGlassPanel.style.visibility = 'hidden';
    }


    function showNotifICall(s_number) {
        // permission already asked when we registered
        if (window.webkitNotifications && window.webkitNotifications.checkPermission() == 0) {
            if (oNotifICall) {
                oNotifICall.cancel();
            }
            oNotifICall = window.webkitNotifications.createNotification('/assets/asterisk/images/sipml-34x39.png', 'Incoming Call', 'Incoming Call from ' + s_number);
            oNotifICall.onclose = function () { oNotifICall = null; };
            oNotifICall.show();

        }
    }

    function onKeyUp(evt) {
        evt = (evt || window.event);
        if (evt.keyCode == 27) {
            fullScreen(false);
        }
        else if (evt.ctrlKey && evt.shiftKey) { // CTRL + SHIFT
            if (evt.keyCode == 65 || evt.keyCode == 86) { // A (65) or V (86)
                bDisableVideo = (evt.keyCode == 65);
                txtCallStatus.innerHTML = '<i>Video ' + (bDisableVideo ? 'disabled' : 'enabled') + '</i>';
                window.localStorage.setItem('org.doubango.expert.disable_video', bDisableVideo);
            }
        }
    }

    function onDivCallCtrlMouseMove(evt) {
        try { // IE: DOM not ready
            if (tsk_utils_have_stream()) {
                btnCall.disabled = (!tsk_utils_have_stream() || !oSipSessionRegister || !oSipSessionRegister.is_connected());
                // document.getElementById("divCallCtrl").onmousemove = null; // unsubscribe
            }
        }
        catch (e) { }
    }

    function uiOnConnectionEvent(b_connected, b_connecting) { // should be enum: connecting, connected, terminating, terminated

        btnCall.disabled = !(b_connected && tsk_utils_have_webrtc() && tsk_utils_have_stream());
        btnHangUp.disabled = !oSipSessionCall;

    }

    function uiVideoDisplayEvent(b_local, b_added) {}

    function uiBtnCallSetText(s_text) {

        $(".window").removeClass('minimized');

        switch (s_text) {
            case "Call":
            {
                var bDisableCallBtnOptions = disable_callbtn_options;
                if (typeof(btnCall) != 'undefined' && btnCall != null)
                {
                    btnCall.value = btnCall.innerHTML = 'Вызов';
                    btnCall.setAttribute("class", bDisableCallBtnOptions ? "btn btn-primary" : "btn btn-primary dropdown-toggle");
                    btnCall.onclick = function () { sipCall('call-audio' ) };
                }


                break;
            }
            default:
            {
                btnCall.value = btnCall.innerHTML = s_text;
                btnCall.setAttribute("class", "btn btn-primary");
                btnCall.onclick = function () {
                    //window.open('/service-102/create', '_blank');
                    markPresent();
                    console.log("Answer Button Clicked");
                    sipCall(bDisableVideo ? 'call-audio' : 'call-audiovideo');
                };
                break;
            }
        }
    }

    function uiCallTerminated(s_description) {
        console.log("uiCallTerminated ->",s_description);

        $('#contactInfo').empty();
        $('#timer').empty();
        // Initialize Call button
        uiBtnCallSetText("Call");
        btnHangUp.value = 'Завершить';
        btnHoldResume.value = 'Удержание';
        btnMute.value = "Отключить звук";
        btnCall.disabled = false;
        btnHangUp.disabled = true;
        document.getElementById('timer').style.display = "none";
        if (window.btnBFCP) window.btnBFCP.disabled = true;

        oSipSessionCall = null;

        stopRingbackTone();
        stopRingTone();

        txtCallStatus.innerHTML = "<i>" + s_description + "</i>";

        divCallOptions.style.opacity = 0;

        if (oNotifICall) {
            oNotifICall.cancel();
            oNotifICall = null;
        }

        setTimeout(function () { if (!oSipSessionCall) txtCallStatus.innerHTML = ''; }, 2500);
    }

    // Callback function for SIP Stacks
    function onSipEventStack(e /*SIPml.Stack.Event*/) {
        tsk_utils_log_info('==stack event = ' + e.type);
        switch (e.type) {
            case 'started':
            {
                // catch exception for IE (DOM not ready)
                try {
                    // LogIn (REGISTER) as soon as the stack finish starting
                    oSipSessionRegister = this.newSession('register', {
                        expires: 200,
                        events_listener: { events: '*', listener: onSipEventSession },
                        sip_caps: [
                            { name: '+g.oma.sip-im', value: null },
                            //{ name: '+sip.ice' }, // rfc5768: FIXME doesn't work with Polycom TelePresence
                            { name: '+audio', value: null },
                            { name: 'language', value: '\"en,fr\"' }
                        ]
                    });
                    oSipSessionRegister.register();
                }
                catch (e) {
                    txtRegStatus.value = txtRegStatus.innerHTML = "<b>1:" + e + "</b>";
                }
                break;
            }
            case 'stopping': case 'stopped': case 'failed_to_start': case 'failed_to_stop':
            {
                var bFailure = (e.type == 'failed_to_start') || (e.type == 'failed_to_stop');
                oSipStack = null;
                oSipSessionRegister = null;
                oSipSessionCall = null;

                uiOnConnectionEvent(false, false);

                stopRingbackTone();
                stopRingTone();

                divCallOptions.style.opacity = 0;

                txtCallStatus.innerHTML = '';
                txtRegStatus.innerHTML = bFailure ? "<i>Не подключено: <b>" + e.description + "</b></i>" : "<i>Не подключено</i>";
                break;
            }
            case 'i_new_call':
            {
                if (oSipSessionCall) {
                    // do not accept the incoming Call if we're already 'in Call'
                    e.newSession.hangup(); // comment this line for multi-line support
                }
                else {
                    console.log("New Call is coming now");
                    oSipSessionCall = e.newSession;
                    // start listening for events
                    oConfigCall = {
                        audio_remote: audioRemote,
                        screencast_window_id: 0x00000000, // entire desktop
                        events_listener: { events: '*', listener: onSipEventSession },
                        bandwidth: { audio: undefined, video: undefined },
                        video_size: { minWidth: undefined, minHeight: undefined, maxWidth: undefined, maxHeight: undefined },
                        sip_caps: [
                            { name: '+g.oma.sip-im' },
                            { name: 'language', value: '\"en,fr\"' }
                        ]
                    };
                    oSipSessionCall.setConfiguration(oConfigCall);
                    divCallCtrl.style.display = "block";
                    uiBtnCallSetText('Ответить');
                    btnHangUp.value = 'Отклонить';
                    btnCall.disabled = false;
                    btnHangUp.disabled = false;

                    startRingTone();

                    var sRemoteNumber = (oSipSessionCall.getRemoteFriendlyName() || 'unknown');
                    console.log(sRemoteNumber);
                    //txtCallStatus.innerHTML = "<i>Входящий звонок от  [<b>" + sRemoteNumber + "</b>]</i>";
                    window.localStorage.setItem('caller-number', sRemoteNumber);
                    document.getElementById('contactInfo').innerHTML = "<i>Входящий звонок от  [<b>" + sRemoteNumber + "</b>]</i>";
                    showNotifICall(sRemoteNumber);

                }
                break;
            }
            case 'm_permission_requested':
            {
                //divGlassPanel.style.visibility = 'visible';
                break;
            }
            case 'm_permission_accepted':
            case 'm_permission_refused':
            {
                //divGlassPanel.style.visibility = 'hidden';
                if (e.type == 'm_permission_refused') {
                    uiCallTerminated('Media stream permission denied');
                }
                break;
            }
            case 'starting': default: break;
        }
    };

    // Callback function for SIP sessions (INVITE, REGISTER, MESSAGE...)
    function onSipEventSession(e /* SIPml.Session.Event */) {
        tsk_utils_log_info('==session event = ' + e.type);

        switch (e.type) {
            case 'connecting': case 'connected':
            {
                var bConnected = (e.type == 'connected');

                if (e.session == oSipSessionRegister) {
                    uiOnConnectionEvent(bConnected, !bConnected);
                    txtRegStatus.innerHTML = "<i>" + e.description + "</i>";
                    $(".success-checkmark").show();
                    $(".check-iconn").hide();
                    setTimeout(function () {
                        $(".check-iconn").show();
                    }, 10);
                }
                else if (e.session == oSipSessionCall) {
                    btnHangUp.value = 'Повесить трубку';
                    btnCall.disabled = true;
                    btnHangUp.disabled = false;

                    //btnTransfer.disabled = false;
                    if (window.btnBFCP) window.btnBFCP.disabled = false;

                    if (bConnected) {
                        stopRingbackTone();
                        stopRingTone();

                        if (oNotifICall) {
                            oNotifICall.cancel();
                            oNotifICall = null;
                        }
                    }
                    console.log("I am connected");
                    console.log("bConnected ",bConnected);
                    txtCallStatus.innerHTML = "<i>" + e.description + "</i>";
                    divCallOptions.style.opacity = bConnected ? 1 : 0;

                    if (SIPml.isWebRtc4AllSupported()) { // IE don't provide stream callback
                        uiVideoDisplayEvent(false, true);
                        uiVideoDisplayEvent(true, true);
                    }
                }
                break;
            } // 'connecting' | 'connected'
            case 'terminating': case 'terminated':
            {
                if (e.session == oSipSessionRegister) {
                    uiOnConnectionEvent(false, false);

                    oSipSessionCall = null;
                    oSipSessionRegister = null;

                    txtRegStatus.innerHTML = "<i>" + e.description + "</i>";
                }
                else if (e.session == oSipSessionCall) {
                    uiCallTerminated(e.description);
                }
                break;
            } // 'terminating' | 'terminated'

            case 'm_stream_video_local_added':
            {
                if (e.session == oSipSessionCall) {
                    uiVideoDisplayEvent(true, true);
                }
                break;
            }
            case 'm_stream_video_local_removed':
            {
                if (e.session == oSipSessionCall) {
                    uiVideoDisplayEvent(true, false);
                }
                break;
            }
            case 'm_stream_video_remote_added':
            {
                if (e.session == oSipSessionCall) {
                    uiVideoDisplayEvent(false, true);
                }
                break;
            }
            case 'm_stream_video_remote_removed':
            {
                if (e.session == oSipSessionCall) {
                    uiVideoDisplayEvent(false, false);
                }
                break;
            }

            case 'm_stream_audio_local_added':
            case 'm_stream_audio_local_removed':
            case 'm_stream_audio_remote_added':
            case 'm_stream_audio_remote_removed':
            {
                break;
            }

            case 'i_ect_new_call':
            {
                oSipSessionTransferCall = e.session;
                break;
            }

            case 'i_ao_request':
            {
                if (e.session == oSipSessionCall) {
                    var iSipResponseCode = e.getSipResponseCode();
                    if (iSipResponseCode == 180 || iSipResponseCode == 183) {
                        startRingbackTone();
                        txtCallStatus.innerHTML = '<i>Remote ringing...</i>';
                    }
                }
                break;
            }

            case 'm_early_media':
            {
                if (e.session == oSipSessionCall) {
                    stopRingbackTone();
                    stopRingTone();
                    txtCallStatus.innerHTML = '<i>Early media started</i>';
                }
                break;
            }

            case 'm_local_hold_ok':
            {
                if (e.session == oSipSessionCall) {
                    if (oSipSessionCall.bTransfering) {
                        oSipSessionCall.bTransfering = false;
                        // this.AVSession.TransferCall(this.transferUri);
                    }
                    btnHoldResume.value = 'Resume';
                    btnHoldResume.disabled = false;
                    txtCallStatus.innerHTML = '<i>Вызов удерживается</i>';
                    oSipSessionCall.bHeld = true;
                }
                break;
            }
            case 'm_local_hold_nok':
            {
                if (e.session == oSipSessionCall) {
                    oSipSessionCall.bTransfering = false;
                    btnHoldResume.value = 'Hold';
                    btnHoldResume.disabled = false;
                    txtCallStatus.innerHTML = '<i>Не удалось перевести удаленную сторону в режим удержания</i>';
                }
                break;
            }
            case 'm_local_resume_ok':
            {
                if (e.session == oSipSessionCall) {
                    oSipSessionCall.bTransfering = false;
                    btnHoldResume.value = 'Hold';
                    btnHoldResume.disabled = false;
                    txtCallStatus.innerHTML = '<i>Звонок снят с удержания</i>';
                    oSipSessionCall.bHeld = false;

                    if (SIPml.isWebRtc4AllSupported()) { // IE don't provide stream callback yet
                        uiVideoDisplayEvent(false, true);
                        uiVideoDisplayEvent(true, true);
                    }
                }
                break;
            }
            case 'm_local_resume_nok':
            {
                if (e.session == oSipSessionCall) {
                    oSipSessionCall.bTransfering = false;
                    btnHoldResume.disabled = false;
                    txtCallStatus.innerHTML = '<i>Не удалось отменить вызов</i>';
                }
                break;
            }
            case 'm_remote_hold':
            {
                if (e.session == oSipSessionCall) {
                    txtCallStatus.innerHTML = '<i>Placed on hold by remote party</i>';
                }
                break;
            }
            case 'm_remote_resume':
            {
                if (e.session == oSipSessionCall) {
                    txtCallStatus.innerHTML = '<i>Taken off hold by remote party</i>';
                }
                break;
            }
            case 'm_bfcp_info':
            {
                if (e.session == oSipSessionCall) {
                    txtCallStatus.innerHTML = 'BFCP Info: <i>' + e.description + '</i>';
                }
                break;
            }

            case 'o_ect_trying':
            {
                if (e.session == oSipSessionCall) {
                    txtCallStatus.innerHTML = '<i>Call transfer in progress...</i>';
                }
                break;
            }
            case 'o_ect_accepted':
            {
                if (e.session == oSipSessionCall) {
                    txtCallStatus.innerHTML = '<i>Call transfer accepted</i>';
                }
                break;
            }
            case 'o_ect_completed':
            case 'i_ect_completed':
            {
                if (e.session == oSipSessionCall) {
                    txtCallStatus.innerHTML = '<i>Call transfer completed</i>';
                    btnTransfer.disabled = false;
                    if (oSipSessionTransferCall) {
                        oSipSessionCall = oSipSessionTransferCall;
                    }
                    oSipSessionTransferCall = null;
                }
                break;
            }
            case 'o_ect_failed':
            case 'i_ect_failed':
            {
                if (e.session == oSipSessionCall) {
                    txtCallStatus.innerHTML = '<i>Call transfer failed</i>';
                    btnTransfer.disabled = false;
                }
                break;
            }
            case 'o_ect_notify':
            case 'i_ect_notify':
            {
                if (e.session == oSipSessionCall) {
                    txtCallStatus.innerHTML = "<i>Call Transfer: <b>" + e.getSipResponseCode() + " " + e.description + "</b></i>";
                    if (e.getSipResponseCode() >= 300) {
                        if (oSipSessionCall.bHeld) {
                            oSipSessionCall.resume();
                        }
                        btnTransfer.disabled = false;
                    }
                }
                break;
            }
            case 'i_ect_requested':
            {
                if (e.session == oSipSessionCall) {
                    var s_message = "Do you accept Call transfer to [" + e.getTransferDestinationFriendlyName() + "]?";//FIXME
                    if (confirm(s_message)) {
                        txtCallStatus.innerHTML = "<i>Call transfer in progress...</i>";
                        oSipSessionCall.acceptTransfer();
                        break;
                    }
                    oSipSessionCall.rejectTransfer();
                }
                break;
            }
        }
    }

} else {
    $(".window").hide();
}