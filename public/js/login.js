// すでにログインしている場合は管理画面へ
    if (localStorage.getItem("loggedIn") === "true") {
      window.location.href = "subscriptions.html";
    }

    function login() {
      const user = document.getElementById("username").value;
      const pass = document.getElementById("password").value;
      const error = document.getElementById("error");

      // 仮の認証情報
      if (user === "admin" && pass === "1234") {
        localStorage.setItem("loggedIn", "true");
        window.location.href = "subscriptions.html";
      } else {
        error.textContent = "ユーザー名またはパスワードが間違っています";
      }
      return false;
    }
