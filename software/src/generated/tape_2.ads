--  This file was generated by bmp2ada
with Giza.Bitmaps.Indexed_1bit;
use Giza.Bitmaps.Indexed_1bit;
with Giza.Image.Bitmap.Indexed_1bit;

package tape_2 is
   pragma Style_Checks (Off);

   Data : aliased constant Bitmap_Indexed := (W => 28, H => 16, Length_Byte => 56,
Palette => (
(R => 82, G => 71, B => 66),
(R => 0, G => 0, B => 0)), Data => (
 252, 255, 255, 35, 0, 0, 64, 241, 0, 240, 152, 18, 128, 146, 5, 250, 5, 90, 176, 95, 176, 13, 250, 13, 90,
 160, 95, 160, 73, 1, 72, 153, 15, 0, 159, 17, 0, 128, 24, 26, 143, 133, 193, 241, 56, 24, 248, 255, 129, 2,
 0, 0, 196, 255, 255, 63));

   Image :
   aliased Giza.Image.Bitmap.Indexed_1bit.Instance
     (Data'Access);
   pragma Style_Checks (On);
end tape_2;
