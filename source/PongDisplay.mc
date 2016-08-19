using Toybox.Ant as Ant;
using Toybox.WatchUi as Ui;
using Toybox.Time as Time;
using Toybox.System as Sys;

class PongDisplay extends Ant.GenericChannel {
   	const DEVICE_TYPE = 1;
    const PERIOD = 1966;
    const TRANSMISSION_TYPE = 1;
    const RADIO_FREQUENCY = 25;

    hidden var chanAssign;

    var data;
    var searching;
    var pastEventCount;
    var deviceCfg;
    
    var payloadRx;

    function initialize() {
        // Get the channel
        chanAssign = new Ant.ChannelAssignment(Ant.CHANNEL_TYPE_RX_NOT_TX, Ant.NETWORK_PUBLIC);
        GenericChannel.initialize(method(:onMessage), chanAssign);

        // Set the configuration
        deviceCfg = new Ant.DeviceConfig( {
            :deviceNumber => 0,                 // Wildcard our search
            :deviceType => DEVICE_TYPE,
            :transmissionType => TRANSMISSION_TYPE,
            :messagePeriod => PERIOD,
            :radioFrequency => RADIO_FREQUENCY,
            :searchTimeoutLowPriority => 4,     // Timeout in 10s
            :searchThreshold => 0} );           // Pair to all transmitting sensors
        GenericChannel.setDeviceConfig(deviceCfg);

        searching = true;
        payloadRx = new [8];
    }

    function open() {
        // Open the channel
        GenericChannel.open();

        searching = true;
    }

	function getBallX() {
		return payloadRx[1];
	}
	
	function getBallY() {
		return payloadRx[2];
	}

    function closeSensor() {
        GenericChannel.close();
    }

    function onMessage(msg) {
        // Parse the payload
        payloadRx = msg.getPayload();
		Sys.println(payloadRx);
    }
}