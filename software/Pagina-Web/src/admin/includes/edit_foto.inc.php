<?php

  include dirname( dirname( dirname( __FILE__))) . "/common/utils.php";
  include dirname( dirname( dirname( __FILE__))) . "/common/config.php";
  include dirname( dirname( dirname( __FILE__))) . "/common/mysql.php";

  # conectamos con la base de datos
  $connection = Connect( $config['database']);

  # Obtenemos el listado de autores
  $sql  = "select * from authors order by name asc";

  $rows = ExecuteQuery( $sql, $connection);

  # Obtenemos los datos de la foto que buscamos
  $sql_foto = "select * from images where id = " . $_GET['id'];
  $rows_f = ExecuteQuery( $sql_foto, $connection);

  $rows_fotos = $rows_f[0];

  if ( $rows_fotos['text'] == 0)
  {
    $enabled = 0;
  }
  else
  {
    $enabled = 1;
  }

?>
<div class="container">
    <div class="row">

      <div class="col-lg-12 text-lett">
        <h2 class="mt-5">Editar foto</h2>
      </div>
  
    </div>
    <div class="row form_new">
      <div class="col-lg-2 text-left"></div>
      <div class="col-lg-10 text-left">
       
        <form role="form" action="actions/edit_foto.act.php" method="post" enctype="multipart/form-data">

          <input type="hidden" name="id" id="id" value="<?php echo $rows_fotos['id']; ?>">
          <div class="form-group row">
            <label for="author_id" class="col-lg-2 col-form-label">Autor</label>
             
              <div class="col-lg-4 text-lett">
                <select  class="form-control" name=author_id id=author_id>
                    <?php
                      foreach ( $rows as $row) 
                      {
                        if ( $row[0] == $rows_fotos['author_id'])
                        {
                          echo "<option value= ".$row[0]." selected>".$row[1]."</option>";
                        }
                        else
                        {
                          echo "<option value= ".$row[0].">".$row[1]."</option>";
                        }
                        
                      }

                    ?>

                </select>
            </div>
           
          </div>

          <div class="form-group row">
            <label for="name" class="col-lg-2 col-form-label">Nombre</label>
             
              <div class="col-lg-4 text-lett">
                <input type="text" class="form-control" id="name" name="name" placeholder="" value="<?php echo $rows_fotos['name']; ?>">
            </div>
           
          </div>

          <div class="form-group row">
            <label for="fichero" class="col-lg-2 col-form-label">Fichero</label>
             
              <div class="col-lg-4 text-lett">
                <input type="file" class="form-control" id="fichero" name="fichero" placeholder="">
                <?php echo $rows_fotos['file']; ?>
            </div>
           
          </div>


          <div class="form-group row">
            <label for="size" class="col-lg-2 col-form-label">Texto</label>
             
              <div class="col-lg-4 text-lett">
                <textarea rows="5" cols="60" id="text" name="text"><?php echo $rows_fotos['text']; ?></textarea>
            </div>
           
          </div>

          <div class="form-group row">
            <label for="enabled" class="col-lg-2 col-form-label">Activado</label>
             
              <div class="col-lg-3 text-lett">
                <input type="checkbox"  id="enabled" name="enabled" <?php echo $enabled; ?>>
            </div>
            
          </div>



          <br><br>
          <button type="submit" class="btn btn-primary">Enviar</button>

        </form>

        <br><br>
      </div>
      <div class="col-lg-2 text-left"></div>
    </div>

  </div>
