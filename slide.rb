class Slide
  attr_accessor :id, :place, :title, :body
  
  def initialize(options)
    @id = options["id"]
    @place = options["place"]
    @title = options["title"]
    @body = options["body"]
  end
  
  # Public: Get a list of all slides from the database.
  #
  # Returns an Array of Slide objects.
  def self.all
    results = DATABASE.execute("SELECT * FROM slides")
    
    results.map { |row_hash| self.new(row_hash) }
  end
  
  def set_prev
    @prev_s = @place - 1
  end
    
  def set_next
    if @place == Slide.all.length
      @next_s = nil
    else
      @next_s = @place + 1
    end
    @next_s
  end
    
  
  # Public: Get a single slide from the database.
  #
  # s_id - Integer
  #
  # Returns a Slide object.
  def self.find(s_place)
    result = DATABASE.execute("SELECT * FROM slides WHERE place = #{s_place}")[0]
    
    self.new(result)
  end
  
  # Returns the object as a Hash.
  def to_hash
    {
      id: id,
      place: place,
      title: title,
      body: body,
      prev_s: set_prev,
      next_s: set_next
    }
  end
  
  # Public: insert
   # Inserts the newly created item into the database.
   #
   # Parameters:
   # none
   #
   # Returns: 
   # @id: the primary key for the new row.
   #
   # State changes:
   # New row is created in the database.
    
  def insert
  
    attributes = []
    instance_variables.each do |i|
      attributes << i.to_s.delete("@") if (i != :@id && i != :@table)
    end
  
    values = []
    attributes.each do |a|
      value = self.send(a)
    
      if value.is_a?(Integer)
        values << "#{value}"
      else values << "'#{value}'"
      end
    end
  
    DATABASE.execute("INSERT INTO slides (#{attributes.join(", ")}) 
                      VALUES (#{values.join(", ")})")
    @id = DATABASE.last_insert_row_id
    return self
  end
  

  # Public: save
   # Updates database with current object values.
   #
   # Parameters:
   # none
   #
   # Returns: 
   # Array containing Hash of data for saved record.
   #
   # State changes:
   # Row values in the database are updated.

  def save
    attributes = []
    
    instance_variables.each do |i|
      attributes << i.to_s.delete("@")
    end
    
    query_components_array = []
    
    attributes.each do |a|
      value = self.send(a)
      
      if value.is_a?(Integer)
        query_components_array << "#{a} = #{value}"
      else
        query_components_array << "#{a} = '#{value}'"
      end
    end
    
    query_string = query_components_array.join(", ")
    # name = 'Sumeet', age = 75, hometown = 'San Diego'

    DATABASE.execute("UPDATE slides SET #{query_string} WHERE id = #{id}")
    return self
  end
  
  # Public: delete
   # Removes a row from the database.
   #
   # Parameters:
   # none
   #
   # Returns: 
   # empty array?
   #
   # State changes:
   # Row is removed from the database.
  
  def delete
    DATABASE.execute("DELETE from slides WHERE id = #{id}")
  end
end