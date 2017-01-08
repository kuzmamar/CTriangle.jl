function createCommandLineOptions()
  options = Dict{String, Function}()

  options[CONSTRAINED] = function(options::String, index::Int,
    commandLine::CommandLine
  )
    commandLine.constrainedDelaunay = true
    commandLine.delaunay = false
    CONSTRAINED
  end

  options[REFINEMENT] = function(options::String, index::Int,
    commandLine::CommandLine
  )
    commandLine.refinement = true
    REFINEMENT
  end

  options[AREA] = function(options::String, index::Int,
    commandLine::CommandLine
  )
    if index === length(options) || isdigit(options[index + 1]) === false
      commandLine.useAreas = true
      commandLine.useRegions = true
    end
    AREA
  end

  options[ATTRIBUTE] = function(options::String, index::Int,
    commandLine::CommandLine
  )
    commandLine.useRegions = true
    ATTRIBUTE
  end

  options[IGNORE_HOLES] = function(options::String, index::Int,
    commandLine::CommandLine
  )
    commandLine.useHoles = false
    IGNORE_HOLES
  end

  options[SECOND_ORDER_ELEMS_LETTER] = function(options::String, index::Int,
    commandLine::CommandLine
  )
    if index < length(options) &&
       string(options[index + 1]) == SECOND_ORDER_ELEMS_NUMBER
       SECOND_ORDER_ELEMS_LETTER
    else
      ""
    end
  end

  options
end

function createExtraOptions()
  return Set{String}(
    String[
      QUALITY, CONVEX, DELAUNAY, JETTISON, EDGE, NEIGHBOR, NO_MARKERS, STEINER,
      QUIET, HELP
    ]
  )
end

function parseOptions(commandLine::CommandLine, options::String)
  parsedOptions = Vector{String}(length(options))
  commandLineOptions = createCommandLineOptions()
  extraOptions = createExtraOptions()
  index = 1
  for option in options
    strOption = string(option)
    if isdigit(strOption) === true || strOption == "."
      parsedOptions[index] = strOption
    elseif in(strOption, extraOptions) === true
      parsedOptions[index] = strOption
    elseif haskey(commandLineOptions, strOption) === true
      parsedOptions[index] = commandLineOptions[strOption](
        options, index, commandLine
      )
    else
      parsedOptions[index] = ""
    end
    index = index + 1
  end
  join(parsedOptions, "")
end

function createCommand(commandLine::CommandLine, options::String,
  fileName::String
)
  if commandLine.delaunay && commandLine.refinement
    DelaunayRefinementFileCommand(
      options,
      NodeName(fileName),
      EleName(fileName),
      AreaName(fileName),
      commandLine.useAreas
    )
  elseif commandLine.constrainedDelaunay && commandLine.refinement
    ConstrainedDelaunayRefinementFileCommand(
      options,
      NodeName(fileName),
      PolyName(fileName),
      EleName(fileName),
      AreaName(fileName),
      commandLine.useHoles,
      false, # regions are not applied during refinement
      commandLine.useAreas
    )
  elseif commandLine.delaunay
    DelaunayFileCommand(options, NodeName(fileName))
  else
    ConstrainedDelaunayFileCommand(
      options,
      NodeName(fileName),
      PolyName(fileName),
      commandLine.useHoles,
      commandLine.useRegions
    )
  end
end
