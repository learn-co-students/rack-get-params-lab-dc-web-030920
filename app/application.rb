class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = ["Milk", "Bread", "Eggs"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each { |item|
        resp.write "#{item}\n"
      }
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end
    #==================== CART
    if req.path.match(/cart/)
        if @@cart == []
          resp.write "Your cart is empty"
        else
          @@cart.each do |item|
          resp.write "#{item}\n"
          end
        end
      end
    #========================= END CART
    #========================= ADD
    if req.path.match(/add/)
      search = req.params["item"]
      # resp.write  
      if @@items.include?(search)
        @@cart << search
        resp.write "added #{search}"
      else
        resp.write "We don't have that item"
      end
    
    end

    #========================= END ADD




    resp.finish
  end # // End of method call

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end #// end of handle_search




end #// end of class
