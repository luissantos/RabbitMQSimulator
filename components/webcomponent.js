jQuery(document).ready(function() {


  var proto = Object.create(HTMLElement.prototype);

  var getPlayerMode = function(element){
      var playerMode = element.getAttribute("player-mode");
      return playerMode == "true";
  }


  proto.createdCallback = function() {

      var simulatorElement = this;

      var simulatorID = this.getAttribute("simulator-id");

      if(simulatorID == null){
        simulatorID = GUID();
      }

      var canvas = document.createElement('canvas');
      canvas.id = simulatorID;
      canvas.setAttribute("data-processing-sources","js/Simulator.pde");

      this.appendChild(canvas);

      var data = this.getElementsByTagName("x-rabbitmq-data");
      var t1_data = '{"exchanges":[],"queues":[],"bindings":[],"producers":[],"consumers":[],"advanced_mode":false}';
      if( data.length > 0 ){
        t1_data = data[0].innerText;
      }



      initSimulator(simulatorID);
      withProcessing(simulatorID, function (pjs, data) {
          pjs.togglePlayerMode(getPlayerMode(simulatorElement));
          loadIntoPlayer(pjs, data);
      }, t1_data);
  };



    var xFoo = document.registerElement('x-rabbitmq-simulator', {
      prototype: proto
    });

    var xDataProto = Object.create(HTMLElement.prototype);

      xDataProto.createdCallback = function() {
          this.style = "display:none";
      };


    var xData = document.registerElement('x-rabbitmq-data', {
      prototype: xDataProto
    });


});
