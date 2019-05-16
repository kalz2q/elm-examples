module Main exposing (..)

import Element exposing (..)
import Element.Background as Background
import Element.Events exposing (..)
import Html

main : Html msg
main =
    layout [ height fill ] <|
        row [ height fill, width fill ]
            [ channelPanel sampleChannels sampleActiveChannel
            , chatPanel sampleActiveChannel sampleMessages
            ]


main =
  laoyout [] <|
    paragraph [] 
      [ el [width <|px 150, height <| 150, margin <| px 10, ]  ]

    <div id="container">
      <div id="randombtn">Random</div><br>
      <div id="board"> 
        <div class="panel" id="panel0">0</div>
        <div class="panel" id="panel1">1</div>
        <div class="panel" id="panel2">2</div>
        <div class="panel" id="panel3">3</div>
        <div class="panel" id="panel4">4</div>
        <div class="panel" id="panel5">5</div>
        <div class="panel" id="panel6">6</div>
        <div class="panel" id="panel7">7</div>
        <div class="panel" id="panel8">8</div> 
      </div>
      <div id="color">color name</div>
      <div id="code">color code</div>
      <div id="similar">similar color</div>
    </div>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="color.json.js"> </script>
    <script>
      $(() => {
        'use strict';
        let colorkeys = Object.keys(colors);
        let colorcodes = Object.values(colors);
        let tempcolors = {};
        for (var i = 0 ; i < colorkeys.length; i++){
          tempcolors[colorcodes[i]]=colorkeys[i];
        }
        var SIZE = 3;
        var currentNum = 0;
        var PANEL_WIDTH = 170;
        var BOARD_PADDING = 10;
        var panels=[];
        var panel;
        var hexDigits = new Array ("0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f");
        function initBoard(){
        for (var i = 0; i < SIZE * SIZE; i++) {
          var c = colorkeys[Math.floor(Math.random()*colorkeys.length)];
          $("#panel"+i).css("background", c);
        }
        };
        initBoard();

        function rgb2hex(rgb) {
          rgb = rgb.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\).*/);
          return "#" + hex(rgb[1]) + hex(rgb[2]) + hex(rgb[3]);
        }
        function hex(x) {
          return isNaN(x) ? "00" : hexDigits[(x - x % 16) / 16] + hexDigits[x % 16];
        }

        function colordistance (x, c) {
          let dist =
            Math.pow(("0x"+x[1]+x[2]) - ("0x"+c[1]+c[2]), 2)
            + Math.pow(("0x"+x[3]+x[4]) - ("0x"+c[3]+c[4]), 2)
            + Math.pow(("0x"+x[5]+x[6]) - ("0x"+c[5]+c[6]), 2);
          return dist;
        }
        console.log(colordistance("#000001", "#000000"));
        function sortcolor( colorcodes, c) {
          colorcodes.sort(function(a, b){return colordistance(a,c) - colordistance(b,c)});
          return colorcodes;
        }

        function refreshboard(colorcodes) {
          for (var i = 0; i < SIZE * SIZE; i++) {
            var c = colorcodes[i];
            $("#panel"+i).css("background", c);
          }
        }
        $(".panel").click(function(){
          var c=rgb2hex($(this).css('background'));
          $("#code").html(c);
          $("#color").html(tempcolors[c]);
        });
        $("#randombtn").click(()=>{
          initBoard();
        });
        $("#similar").click(()=>{
          var c=$("#code").html()
          sortcolor(colorcodes, c);
          refreshboard(colorcodes);
        });
      });

