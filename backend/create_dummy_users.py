import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'ashrutpurva.settings')
django.setup()

from django.contrib.auth import get_user_model

User = get_user_model()

def create_dummy_users():
    # Create Admin
    admin_email = 'admin@example.com'
    if not User.objects.filter(email=admin_email).exists():
        User.objects.create_superuser(
            email=admin_email,
            password='Password123!',
            role='ADMIN'
        )
        print(f"Admin created: {admin_email}")
    else:
        print(f"Admin already exists: {admin_email}")

    # Create End User
    user_email = 'user@example.com'
    if not User.objects.filter(email=user_email).exists():
        User.objects.create_user(
            email=user_email,
            password='Password123!',
            role='USER'
        )
        print(f"End User created: {user_email}")
    else:
        print(f"End User already exists: {user_email}")

if __name__ == '__main__':
    try:
        create_dummy_users()
    except Exception as e:
        print(f"Error: {e}")
        print("Make sure your PostgreSQL server is running and the 'ashrutpurva' DB is created.")
