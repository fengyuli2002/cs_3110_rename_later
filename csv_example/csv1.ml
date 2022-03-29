See also 'test.ml' for examples, and 'csv.mli' for documentation.

open Printf

let embedded_csv =
  "\"I miss java ---- \",\"2112 ----\",\n\
   \"Me too ------- \",\"5555 -----\""
(* let csvs = List.map (fun name -> (name, Csv.load name)) [
   "csv_example/example1.csv"; "csv_example/example2.csv" ] *)

let csvs =
  List.map
    (fun name -> (name, Csv.load name))
    [ "csv_example/example1.csv" ]

let () =
  let ecsv = Csv.input_all (Csv.of_string embedded_csv) in
  (* printf "---Embedded CSV-----------------\n"; *)
  Csv.print_readable ecsv;
  List.iter
    (fun (name, csv) ->
      (* printf "---%s--------------\n" name; *)
      Csv.print_readable csv)
    csvs;
  printf "Compare (Embedded CSV) example1.csv = %i\n"
    (Csv.compare ecsv (snd (List.hd csvs)))

let () =
  (* Save it to a file *)
  let ecsv = Csv.input_all (Csv.of_string embedded_csv) in
  let fname =
    (* Filename.concat (Filename.get_temp_dir_name ()) "example.csv" *)
    Filename.concat Filename.current_dir_name "csv_example/example.csv"
  in
  Csv.save fname ecsv;
  printf "Saved CSV to file %S.\n" fname