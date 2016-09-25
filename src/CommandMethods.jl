get_input(::Command) = error("Implement get_input method.")

function execute(cmd::Command)
  input = get_input(cmd)
  triangulate(input)
end



function execute(cmd::DelaunayCommand)
  read(NodeFileName(file_name, true))
end
