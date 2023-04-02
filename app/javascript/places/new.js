function initMap() {
  // 位置情報を取得
  navigator.geolocation.getCurrentPosition(function (position) {
    let LatLng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
    let geocoder = new google.maps.Geocoder();
    let map;
    let inputLat = document.getElementById('place_latitude')
    let inputLng = document.getElementById('place_longitude')
    let inputAddress = document.getElementById('place_address')
    let textAddress = document.getElementById('text_address')

    // APIのジオコーダを使い、緯度経度から住所を割り出す（逆ジオコーディング）
    geocoder.geocode(
      {
        latLng: LatLng
      },
      function(results, status) {
        let address = "";
        if (status == google.maps.GeocoderStatus.OK) {
          // 取得が成功した場合、住所を取得します。
          address = results[0].formatted_address.replace(/^日本、/, '');
        } else {
          alert('Error:' + status);
        }
        // 住所の結果表示をします。
        textAddress.textContent = address;
        inputAddress.value = address;
      }
    );

    inputLat.value = position.coords.latitude
    inputLng.value = position.coords.longitude
  
    // 取得した位置情報を中心に表示
    map = new google.maps.Map(document.getElementById('map'), {
      center: LatLng,
      zoom: 18
    });

    // 取得した位置にピンをセット
    marker = new google.maps.Marker({
      position: LatLng,
      map,
      draggable: true
    });

    // // 住所を打ち込んだ際、mapを再度リロードさせる
    // document.getElementById('address-reload').addEventListener('click', function() {
    //   geocoder.geocode( { address: inputAddress.value }, function(results, status) {
    //     if (status === google.maps.GeocoderStatus.OK) {
    //       LatLng = new google.maps.LatLng(results[0].geometry.location.lat(), results[0].geometry.location.lng());
    //       inputLat.value = results[0].geometry.location.lat()
    //       inputLng.value = results[0].geometry.location.lng()

    //       map = new google.maps.Map(document.getElementById('map'), {
    //         center: LatLng,
    //         zoom: 18
    //       });

    //       marker = new google.maps.Marker({
    //         position: LatLng,
    //         map,
    //         draggable: true
    //       });
    //     } else {
    //       alert('Error:' + status);
    //     }
    //   })
    // })


    // ピンを移動させたときに、緯度経度を変更する
    google.maps.event.addListener(marker, 'dragend', function(ev){
      inputLat.value = ev.latLng.lat();
      inputLng.value = ev.latLng.lng();

      LatLng = new google.maps.LatLng(ev.latLng.lat(), ev.latLng.lng());

      // ピン移動時、再度住所を割り出す
      geocoder.geocode(
        {
          latLng: LatLng
        },
        function(results, status) {
          let address = "";
          if (status == google.maps.GeocoderStatus.OK) {
            // 取得が成功した場合、住所を取得します。
            address = results[0].formatted_address.replace(/^日本、/, '');
          } else {
            alert('Error:' + status);
          }
          // 住所の結果表示をします。
          textAddress.textContent = address;
          inputAddress.value = address;
        }
      );
    });
  });
}
initMap();