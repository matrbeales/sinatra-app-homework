require "pg"
class Animal
  attr_accessor :id, :animal_name, :latin_name, :description

  def self.open_connection
    return PG.connect(dbname: "zoo", user: "postgres", password: "password")
  end

  def self.all
    conn = self.open_connection

    sql = "SELECT * FROM animal ORDER BY id;"

    results = conn.exec(sql)

    animals = results.map do |tuple|
      self.hydrate tuple
    end

    return animals
  end

  def self.hydrate animal_data
    animal = Animal.new

    animal.id = animal_data["id"]
    animal.animal_name = animal_data["animal_name"]
    animal.latin_name = animal_data["latin_name"]
    animal.description = animal_data["description"]

    return animal
  end

  def self.find id
    conn = self.open_connection

    sql = "SELECT * FROM animal WHERE id = #{id};"

    result = conn.exec(sql).first

    animal = self.hydrate result

    return animal
  end

  def save
    conn = Animal.open_connection

    if !self.id
      sql = "INSERT INTO animal(animal_name, latin_name, description) VALUES('#{self.animal_name}', '#{self.latin_name}', '#{self.description}');"
    else
      sql = "UPDATE animal SET animal_name = '#{self.animal_name}', latin_name = '#{self.latin_name}', description = '#{self.description}' WHERE id = #{self.id};"
    end

    conn.exec(sql)
  end

  def self.destroy id
    conn = self.open_connection

    sql = "DELETE FROM animal WHERE id = #{id};"

    conn.exec(sql)
  end

end
