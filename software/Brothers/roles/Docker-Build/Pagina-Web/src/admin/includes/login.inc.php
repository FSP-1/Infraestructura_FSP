<div class="container">
  <div class="row">

    <div class="col-lg-3"></div>
    <div class="col-lg-6 form_login">
      
      <form class="form-signin" method="post" action="actions/login.act.php">
        <h4 class="form-signin-heading">Por favor, registrese</h4>
        <label for="inputEmail" class="sr-only">Email</label>
        <input type="email" id="email_login" name="email_login" class="form-control frm_login_email" placeholder="Email" required autofocus>
        <label for="inputPassword" class="sr-only">Contraseña</label>
        <input type="password" id="login_password" name="login_password" class="form-control frm_login_pass" placeholder="Contraseña" required>

        <button class="btn btn-lg btn-primary btn-block" type="submit">Enviar</button>
        <br><br>
        <a class="btn btn-lg btn-warning btn-block" href="index.php?page=new">Alta nuevo autor</a>
    </form>

    </div>
    <div class="col-lg-3"></div>

  </div>

</div>