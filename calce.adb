with Text_IO; use Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with ada.strings.unbounded; use ada.strings.unbounded;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;

procedure calce is
   n : integer;
   filename : unbounded_string;

   procedure keepe(n : integer; filename : unbounded_string) is
     d : array(0..(n + 1)) of integer;
     test : float;
     m : integer := 4;
     i, j, carry, temp : integer;
     fp : file_type;
   begin
      Ada.Integer_Text_IO.Default_Width := 0;

      test := (float(n) + 1.0) * 2.30258509;
      loop
         exit when ((float(m) * (log(float(m)) - 1.0)) + 0.5 * log(6.2831852 * float(m))) > test;
         m := m + 1;
      end loop;
      declare
         coef : array(0..(m + 1)) of integer;
      begin
         j := 2;
         loop
            exit when j > m;
            coef(j - 2) := 1;
            j := j + 1;
         end loop;
         d(0) := 2;
         i := 1;
         loop
            exit when i > n;
            carry := 0;
            j := m;
            loop
               exit when j < 2;
               temp := coef(j - 2) * 10 + carry;
               carry := temp/j;
               coef(j - 2) := temp - carry * j;
               j := j - 1;
            end loop;
            d(i) := carry;
            i := i + 1;
         end loop;

         create(fp, out_file, To_String(filename));

         put(fp, d(0));
         put(fp, ".");
         i := 1;
         loop
            exit when i = n;
            put(fp, d(i));
            i := i + 1;
         end loop;

         close(fp);
      end;
   end keepe;


begin
	put("Enter the number of significant digits to calculate: ");
	get(n);
	skip_line;
	put("Enter the output location file-name: ");
	get_line(filename);
	keepe(n, filename);
end calce;