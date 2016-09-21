
function read_node_file(filename::String)

end

function read_poly_file(filename::String)
  print("poly file read.")
end

function read_file(filename::String, open_handler::Function, read_handler::Function)
  is = open_handler(filename)
  input = read_handler(is)
  close(is)
  return input
end

# Computes the delaunay triangulation from nodes in the node file.
function delaunay(filename::String)
  input = read_node_file(filename)
end


function delaunay(filename::String, switches::String)

end

# Computes the constrained delaunay triangulation from poly file.
function constrained_delaunay(filename::String)

end

function constrained_delaunay(filename::String, switches::String)

end

function delaunay_refinement(filename::String, switches::String)

end
