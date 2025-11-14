from django.core.management.base import BaseCommand
from octofit_tracker.models import User, Team, Activity, Workout, Leaderboard
from django.utils import timezone

class Command(BaseCommand):
    help = 'Populate the octofit_db database with test data'

    def handle(self, *args, **kwargs):


        # Use PyMongo to clear collections to avoid Djongo ORM delete issues
        from pymongo import MongoClient
        client = MongoClient('localhost', 27017)
        db = client['octofit_db']
        db.activity.delete_many({})
        db.workout.delete_many({})
        db.leaderboard.delete_many({})
        db.user.delete_many({})
        db.team.delete_many({})


        # Create teams
        marvel = Team.objects.create(name='Marvel', description='Team Marvel Superheroes')
        dc = Team.objects.create(name='DC', description='Team DC Superheroes')

        # Create users
        spiderman = User.objects.create(name='Spider-Man', email='spiderman@marvel.com', team=marvel)
        ironman = User.objects.create(name='Iron Man', email='ironman@marvel.com', team=marvel)
        wonderwoman = User.objects.create(name='Wonder Woman', email='wonderwoman@dc.com', team=dc)
        batman = User.objects.create(name='Batman', email='batman@dc.com', team=dc)

        # Create activities
        Activity.objects.create(user=spiderman, type='Running', duration=30, date=timezone.now().date())
        Activity.objects.create(user=ironman, type='Cycling', duration=45, date=timezone.now().date())
        Activity.objects.create(user=wonderwoman, type='Swimming', duration=25, date=timezone.now().date())
        Activity.objects.create(user=batman, type='Yoga', duration=60, date=timezone.now().date())

        # Create workouts
        Workout.objects.create(name='Hero HIIT', description='High intensity interval training for heroes', suggested_for='Marvel')
        Workout.objects.create(name='Power Yoga', description='Yoga for strength and flexibility', suggested_for='DC')

        # Create leaderboards
        Leaderboard.objects.create(team=marvel, points=100)
        Leaderboard.objects.create(team=dc, points=90)

        self.stdout.write(self.style.SUCCESS('octofit_db database populated with test data!'))

        # Ensure unique index on email field for users
        db.user.create_index([('email', 1)], unique=True)
        client.close()
