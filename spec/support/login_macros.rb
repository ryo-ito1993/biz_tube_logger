module LoginMacros
  def login(user)
    session_params = { email: user.email, password: "password" }
    post api_sessions_path, params: session_params
    JSON.parse(response.body)["token"]
  end
end