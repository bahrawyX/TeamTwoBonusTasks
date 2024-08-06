import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from lms import app
import pytest

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_home_page(client):
    """Test the home page route."""
    response = client.get('/')
    assert response.status_code == 200
    assert b"Welcome" in response.data  # Adjust according to your homepage content

def test_add_book(client):
    """Test adding a book."""
    response = client.post('/add_book', data={
        'isbn': '1234567890',
        'title': 'Test Book',
        'author': 'Test Author',
        'quantity': 1
    })
    assert response.status_code == 302  # Expecting a redirect after adding
