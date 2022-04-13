<script type="text/javascript">
  
  function delete_post( id)
  {
    var ok = confirm( "¿ Seguro de borrar esta imagen ? ");
    if ( !ok)
    {
      return false;
    }
    else
    {
      location.href = "delete.php?page=listado&id=" + id;
    }
  }

</script>

  <div class="container">
    <div class="row">

      <div class="col-lg-12 text-lett">
        <h2 class="mt-5">Listado de fotos</h2>
      </div>
  
    </div>
    <div class="row">

      <div class="col-lg-12 text-lett">
        <a class="btn btn-lg btn-warning" href="home.php?page=new">Nueva foto</a>
      </div>
  
    </div>

    <div class="row cuadro_listado_fotos">
      <div class="col-lg-12">

        <table class="table">
          <thead>
            <tr>
              <th scope="col">#</th>
              <th scope="col">Nombre autor</th>
              <th scope="col">Fichero</th>
              <th scope="col">Creado</th>
              <th scope="col">Activo</th>
              <th scope="col">Editar</th>
              <th scope="col">Eliminar</th>
            </tr>
            </tr>
          </thead>
          <tbody>
            <?php

             
              if ( !empty( $rows))
              {


              foreach ( $rows as $row) 
              {


                if ( $row['enabled'] == "1")
                {
                  $enabled = "<img src='../assets/img/activo.png'  width=20px>";
                }
                else
                {
                  $enabled = "<img src='../assets/img/no_activo.png' width=20px>";
                }

                echo '
                  <td>'.$row['id'].'</td>
                  <td>'.$row['autor'].'</td>
                  <td>'.$row['name'].'</td>
                  <td>'.date( "d/m/Y H:s:i", strtotime( $row['created'])).'</td>
                  <td>'.$enabled.'</td>
                  <td><a href="home.php?page=edit&id='.$row['id'].'"><img src="../assets/img/edit.png" width=20px></a></td>
                  <td><a href="#" OnClick="delete_post('.$row['id'].')"><img src="../assets/img/delete_2.png"  width=20px></a></td>
                  </tr>
                ';  
              }
              }
              else
              {
                echo "<tr><td colspan=7> No hay registros</td></tr>";
              }
            ?>


          </tbody>
        </table>

      </div>
    </div>
    
  </div>
