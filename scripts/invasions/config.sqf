#define HEURES 3600
#define MINUTES 60

BwS_var_casernes = false;

if (BwS_var_casernes) then
{
	// temps entre la productions d'unités par caserne
	BwS_var_cooldown_production_unites_pedestres = 45*MINUTES; // une heure entre chaque production

	// probabilité qu'une caserne soit détruite à tout jamais 0 à 1
	BwS_var_probabilite_caserne_detruite_pour_toujours = 0.8;

	// temps entre les reconstructions si caserne detruite et qu'elle n'est pas perdue pour toujours
	BwS_var_cooldown_de_reconstruction_casernes = 5*HEURES; // 5 heures avant de faire reconstruire
};

BwS_var_usines = false;

if (BwS_var_usines) then
{
	// temps entre la productions d'unités par caserne
	BwS_var_cooldown_production_unites_motorisees = 1*HEURES; // une heure entre chaque production

	// probabilité qu'une caserne soit détruite à tout jamais 0 à 1
	BwS_var_probabilite_usine_detruite_pour_toujours = 0.8;

	// temps entre les reconstructions si caserne detruite et qu'elle n'est pas perdue pour toujours
	BwS_var_cooldown_de_reconstruction_usines = 5*HEURES; // 5 heures avant de faire reconstruire
};

BwS_var_taille_zone = 4000;