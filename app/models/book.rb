class Book < ApplicationRecord
	validates :title, presence: true
	#make sure book titles aren't too long
	# validates :author_id, presence: true
	validates :year_published, numericality: {only_integer: true}
	validates :title, uniqueness: {scope: :author_id, message: "There is already a book with this title by this author in the library."}
	belongs_to :author
	has_many :read_books
	has_many :readers, through: :read_books, source: :user
	def self.this_year(session)
		self.joins(:read_books).where("date_read > ?", DateTime.now.beginning_of_year.strftime("%m/%d/%y")).where("user_id = ?", session[:user_id])
	end

	def self.my_books(session)
		self.joins(:read_books).where("user_id =?", session[:user_id]).order(:date_read)
	end

	def self.authors_books(author_id)
		self.where(author_id: author_id)
	end

	def self.results(query)
		title_results = self.all.select{|book| book.title.downcase.include?(query.downcase)}
		author_results = self.joins(:author).where("name = ?", query.titleize)
		results = title_results.concat(author_results)
	end

	def author_name=(name_input)
		names = Author.all.map{|author| author.name.downcase}
		found = names.find_index{|n| n == name_input.downcase}
		if found
			self.author = Author.all[found]
		else
			self.author = Author.create(name: name_input.titleize)
		end
	end

	def author_name
		if self.author
			self.author.name 
		else
			nil 
		end
	end
end
