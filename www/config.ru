use Rack::Static, :urls=>%w'/index.html /why.html /documentation.html /development.html /css /rdoc', :root=>'public'
run proc{[302, {'Content-Type'=>'text/html', 'Location'=>'index.html'}, []]}
