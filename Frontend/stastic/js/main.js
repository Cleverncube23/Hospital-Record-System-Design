document.getElementById('login-form').addEventListener('submit', function(e) {
    e.preventDefault();
    
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;

    fetch('/login', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ username, password }),
    })
    .then(response => response.json())
    .then(data => {
        if (data.message === 'Logged in successfully.') {
            document.getElementById('message').textContent = 'Login successful!';
            // Redirect to appropriate dashboard based on user role
            switch(data.role) {
                case 'clerk':
                    window.location.href = '/clerk_dashboard';
                    break;
                case 'doctor':
                    window.location.href = '/doctor_dashboard';
                    break;
                case 'nurse':
                    window.location.href = '/nurse_dashboard';
                    break;
                // Add cases for other roles
            }
        } else {
            document.getElementById('message').textContent = 'Invalid username or password.';
        }
    })
    .catch((error) => {
        console.error('Error:', error);
        document.getElementById('message').textContent = 'An error occurred. Please try again.';
    });
});
