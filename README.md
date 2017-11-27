# SE-ANE-ActionScript-VolumeController<hr>
The VolumeController là một class độc lập. Bạn có thể truy cập vào controller qua VolumeController.instance.
Một khi bạn đã truy vào VolumeController.instance thì biến systemVolume sẽ kiểm tra âm lượng của hệ thống hiện tại.

                  volumeSlider.value = VolumeController.instance.systemVolume;
                  
Biến systemVolume luôn cho biết giá trị âm lượng hiện tại của hệ thống, vì vậy bạn có thể kiểm tra bất cứ lúc nào.

1.VolumeEvent.VOLUME_CHANGED.
Tạo một hàm lắng nghe sự kiện. Thuộc tính volume của VolumeEvent luôn mang giá trị âm lượng hiện tại của hệ thống.

                  VolumeController.instance.addEventListener( VolumeEvent.VOLUME_CHANGED, onVolumeChanged );
                  private function onVolumeChanged( event:VolumeEvent ):void {
                    trace( "System volume changed:", event.volume );
                    volumeSlider.value = event.volume;
                  }
                  
 Khi bạn nhận được sự kiện này, âm lượng hệ thống đã được thay đổi bởi người dùng tác động qua ứng dụng AIR.
 VolumeEvent.volume là một giá trị nằm trong khoảng 0 và 1.
 Cập nhật giá trị âm lượng mới.
 
 2. Thay đổi âm lượng hệ thống
 Khi ứng dụng AIR muốn điều chỉnh âm lượng sẽ gọi đến phương thức VolumeController.setVolume() :
         
         private function onSliderChange( event:Event ):void {
          var value:Number = volumeSlider.value;
          trace( "Set volume to:", value );
          VolumeController.instance.setVolume( value );
        }
        
 Giá trị được truyền đến setVolume() phải nằm trong khoảng (0,1).
