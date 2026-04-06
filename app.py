from flask import Flask, render_template, request, redirect, url_for, flash
from flask_sqlalchemy import SQLAlchemy
from config import Config
import datetime

app = Flask(__name__)
app.config.from_object(Config)
db = SQLAlchemy(app)

# Models
class Artist(db.Model):
    __tablename__ = 'artist'
    artist_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    birthplace = db.Column(db.String(100), nullable=False)
    age = db.Column(db.Integer, nullable=False)
    style = db.Column(db.String(100), nullable=False)
    artworks = db.relationship('Artwork', backref='artist', lazy=True, cascade='all, delete-orphan')

class Artwork(db.Model):
    __tablename__ = 'artwork'
    artwork_id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    year = db.Column(db.Integer, nullable=False)
    type = db.Column(db.String(100), nullable=False)
    price = db.Column(db.Float, nullable=False)
    artist_id = db.Column(db.Integer, db.ForeignKey('artist.artist_id', ondelete='CASCADE'), nullable=False)
    purchases = db.relationship('Purchase', backref='artwork', lazy=True, cascade='all, delete-orphan')

class Category(db.Model):
    __tablename__ = 'category'
    category_id = db.Column(db.Integer, primary_key=True)
    category_name = db.Column(db.String(100), nullable=False)

class Customer(db.Model):
    __tablename__ = 'customer'
    customer_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    address = db.Column(db.String(100), nullable=False)
    total_spent = db.Column(db.Float, nullable=False)
    liking = db.Column(db.String(100), nullable=False)
    purchases = db.relationship('Purchase', backref='customer', lazy=True, cascade='all, delete-orphan')

class Purchase(db.Model):
    __tablename__ = 'purchase'
    purchase_id = db.Column(db.Integer, primary_key=True)
    customer_id = db.Column(db.Integer, db.ForeignKey('customer.customer_id', ondelete='CASCADE'), nullable=False)
    artwork_id = db.Column(db.Integer, db.ForeignKey('artwork.artwork_id', ondelete='CASCADE'), nullable=False)

@app.context_processor
def inject_current_year():
    return {'current_year': datetime.date.today().year}

@app.route('/')
def index():
    return render_template('index.html')

# Artist
@app.route('/artists')
def artists():
    items = Artist.query.order_by(Artist.artist_id).all()
    return render_template('artists.html', artists=items)

@app.route('/artists/add', methods=['POST'])
def add_artist():
    try:
        artist = Artist(
            artist_id=int(request.form['artist_id']),
            name=request.form['name'],
            birthplace=request.form['birthplace'],
            age=int(request.form['age']),
            style=request.form['style']
        )
        db.session.add(artist)
        db.session.commit()
        flash('Artist added successfully', 'success')
    except Exception as e:
        db.session.rollback()
        flash('Could not add artist: ' + str(e), 'danger')
    return redirect(url_for('artists'))

@app.route('/artists/delete/<int:artist_id>')
def delete_artist(artist_id):
    try:
        obj = Artist.query.get(artist_id)
        if obj:
            db.session.delete(obj)
            db.session.commit()
            flash('Artist deleted successfully!', 'success')
        else:
            flash('Artist not found', 'warning')
    except Exception as e:
        db.session.rollback()
        flash('Error deleting artist: ' + str(e), 'danger')
    return redirect(url_for('artists'))

# Artwork
@app.route('/artworks')
def artworks():
    items = Artwork.query.order_by(Artwork.artwork_id).all()
    return render_template('artworks.html', artworks=items)

@app.route('/artworks/add', methods=['POST'])
def add_artwork():
    try:
        art = Artwork(
            artwork_id=int(request.form['artwork_id']),
            title=request.form['title'],
            year=int(request.form['year']),
            type=request.form['type'],
            price=float(request.form['price']),
            artist_id=int(request.form['artist_id'])
        )
        db.session.add(art)
        db.session.commit()
        flash('Artwork added', 'success')
    except Exception as e:
        db.session.rollback()
        flash('Could not add artwork: ' + str(e), 'danger')
    return redirect(url_for('artworks'))

@app.route('/artworks/delete/<int:artwork_id>')
def delete_artwork(artwork_id):
    try:
        obj = Artwork.query.get(artwork_id)
        if obj:
            db.session.delete(obj)
            db.session.commit()
            flash('Artwork deleted successfully!', 'success')
        else:
            flash('Artwork not found', 'warning')
    except Exception as e:
        db.session.rollback()
        flash('Error deleting artwork: ' + str(e), 'danger')
    return redirect(url_for('artworks'))

# Category
@app.route('/categories')
def categories():
    items = Category.query.order_by(Category.category_id).all()
    return render_template('categories.html', categories=items)

@app.route('/categories/add', methods=['POST'])
def add_category():
    try:
        category = Category(
            category_id=int(request.form['category_id']),
            category_name=request.form['category_name']
        )
        db.session.add(category)
        db.session.commit()
        flash('Category added', 'success')
    except Exception as e:
        db.session.rollback()
        flash('Could not add category: ' + str(e), 'danger')
    return redirect(url_for('categories'))

@app.route('/categories/delete/<int:category_id>')
def delete_category(category_id):
    try:
        obj = Category.query.get(category_id)
        if obj:
            db.session.delete(obj)
            db.session.commit()
            flash('Category deleted successfully!', 'success')
        else:
            flash('Category not found', 'warning')
    except Exception as e:
        db.session.rollback()
        flash('Error deleting category: ' + str(e), 'danger')
    return redirect(url_for('categories'))

# Customer
@app.route('/customers')
def customers():
    items = Customer.query.order_by(Customer.customer_id).all()
    return render_template('customers.html', customers=items)

@app.route('/customers/add', methods=['POST'])
def add_customer():
    try:
        cust = Customer(
            customer_id=int(request.form['customer_id']),
            name=request.form['name'],
            address=request.form['address'],
            total_spent=float(request.form['total_spent']),
            liking=request.form['liking']
        )
        db.session.add(cust)
        db.session.commit()
        flash('Customer added', 'success')
    except Exception as e:
        db.session.rollback()
        flash('Could not add customer: ' + str(e), 'danger')
    return redirect(url_for('customers'))

@app.route('/customers/delete/<int:customer_id>')
def delete_customer(customer_id):
    try:
        obj = Customer.query.get(customer_id)
        if obj:
            db.session.delete(obj)
            db.session.commit()
            flash('Customer deleted successfully!', 'success')
        else:
            flash('Customer not found', 'warning')
    except Exception as e:
        db.session.rollback()
        flash('Error deleting customer: ' + str(e), 'danger')
    return redirect(url_for('customers'))

# Purchase
@app.route('/purchases')
def purchases():
    items = Purchase.query.order_by(Purchase.purchase_id).all()
    return render_template('purchases.html', purchases=items)

@app.route('/purchases/add', methods=['POST'])
def add_purchase():
    try:
        purchase = Purchase(
            purchase_id=int(request.form['purchase_id']),
            customer_id=int(request.form['customer_id']),
            artwork_id=int(request.form['artwork_id'])
        )
        db.session.add(purchase)
        db.session.commit()
        flash('Purchase added', 'success')
    except Exception as e:
        db.session.rollback()
        flash('Could not add purchase: ' + str(e), 'danger')
    return redirect(url_for('purchases'))

@app.route('/purchases/delete/<int:purchase_id>')
def delete_purchase(purchase_id):
    try:
        obj = Purchase.query.get(purchase_id)
        if obj:
            db.session.delete(obj)
            db.session.commit()
            flash('Purchase deleted successfully!', 'success')
        else:
            flash('Purchase not found', 'warning')
    except Exception as e:
        db.session.rollback()
        flash('Error deleting purchase: ' + str(e), 'danger')
    return redirect(url_for('purchases'))

if __name__ == '__main__':
    app.run(debug=True)
