require 'optimist'

opts = Optimist::options do
    opt :sets, "Lego sets", :type => :string
end

abort("Must provide --sets with space seperated list of set ID's") if !opts[:sets]

p opts
