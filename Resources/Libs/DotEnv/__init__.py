import os
from dotenv import load_dotenv, dotenv_values

class DotEnv:

    def __init__(self, env=None):
            
            self.env=env
            self.load_dotenv()

    def load_dotenv(self):
        
        for key in dotenv_values().keys():
            if key in os.environ:
                del os.environ[key]

        if self.env:
             load_dotenv(f"Resources/Ambiente/{self.env}.env")
        else:
             load_dotenv()