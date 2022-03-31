open Rep
open Controller
open Printf

let db : database = Controller.get_parent_db
let conc_comma = String.concat ","
let conc_line = String.concat "\n"

let rec type_to_string = function
  | [] -> []
  | h :: t ->
      let type_helper (t : Type.data_type) =
        match t with
        | Int -> "Int"
        | Float -> "Float"
        | String -> "String"
      in
      type_helper h :: type_to_string t

let rec get_main_table table_name cols =
  match cols with
  | [] -> []
  | h :: t ->
      (get_column_data db table_name h |> conc_comma)
      :: get_main_table table_name t

let get_file table_name =
  let field_names_pair =
    get_field_name_list db table_name |> List.split
  in
  let field_name_lst = field_names_pair |> fst in
  let field_name_string = field_name_lst |> conc_comma in
  let field_name_type =
    field_names_pair |> snd |> type_to_string |> conc_comma
  in
  let main_table = get_main_table table_name field_name_lst in
  let whole_talbe =
    field_name_string :: field_name_type :: main_table
  in
  whole_talbe |> conc_line

let save_file table_name =
  (* Save it to a file *)
  let ecsv = Csv.input_all (Csv.of_string (get_file table_name)) in
  let fname =
    (* Filename.concat (Filename.get_temp_dir_name ()) "example.csv" *)
    Filename.concat Filename.current_dir_name ("csv_files/" ^ table_name)
  in
  Csv.save fname ecsv;
  printf "Saved CSV to file %S.\n" fname

(** MS3 below this line *)

(* let read_file table_name = let file_data = List.map (fun name ->
   (name, Csv.load name)) [ "csv_files/" ^ table_name ] in file_data

   let () = let ecsv = Csv.input_all (Csv.of_string embedded_csv) in (*
   printf "---Embedded CSV-----------------\n"; *) Csv.print_readable
   ecsv; List.iter (fun (name, csv) -> (* printf "---%s--------------\n"
   name; *) Csv.print_readable csv) csvs; printf "Compare (Embedded
   CSV)\n example1.csv = %i\n" (Csv.compare ecsv (snd (List.hd
   csvs))) *)
